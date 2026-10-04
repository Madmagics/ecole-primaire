-- 2026-10-04 : coffres a doublons de la boutique (onglet Cartes, 2e ligne).
-- Ajoute le type d'evenement 'doublons_echanges' et sa prise en compte dans fn_pousser_evenements.
-- Script rejouable sans risque (IF NOT EXISTS / CREATE OR REPLACE), ne touche a aucune donnee.
-- A lancer sur le VPS :
--   sudo docker exec -i supabase-db psql -U postgres -d postgres -v ON_ERROR_STOP=1 < ~/doublons_echanges.sql

alter type type_evenement add value if not exists 'doublons_echanges';

CREATE OR REPLACE FUNCTION public.fn_pousser_evenements(p_jeton text, p_evenements jsonb)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'extensions'
AS $function$
declare
	v_compte_id text;
	v_evt jsonb;
	v_id text;
	v_type text;
	v_payload jsonb;
	v_horodatage timestamptz;
	v_ids_appliques text[] := '{}';
	v_deja_inseree boolean;
	v_rarity text;
	v_montant int;
	v_card_id text;
	v_grade text;
	v_subject text;
	v_actif boolean;
	v_active_reset jsonb;
	v_doublon record;
begin
	select compte_id into v_compte_id from sessions
	where jeton = p_jeton and expire_le > now();
	if v_compte_id is null then
		raise exception 'session_expiree';
	end if;
	-- Preuve de presence (2026-09-13, chantier "conflit de connexion", voir fn_login) - une poussee
	-- d'evenements est une activite comme une autre, pas la peine d'attendre le prochain
	-- fn_pulse_session() dedie pour la refleter.
	update sessions set derniere_activite = now() where jeton = p_jeton;

	for v_evt in select * from jsonb_array_elements(p_evenements)
	loop
		v_id := v_evt->>'id';
		v_type := v_evt->>'type';
		v_payload := v_evt->'payload';
		v_horodatage := (v_evt->>'horodatage_client')::timestamptz;

		insert into evenements (id, compte_id, type, payload, horodatage_client)
		values (v_id, v_compte_id, v_type::type_evenement, v_payload, v_horodatage)
		on conflict (id) do nothing;

		get diagnostics v_deja_inseree = row_count;
		-- row_count = 1 si la ligne vient d'etre inseree (nouvelle), 0 si elle existait deja
		-- (ON CONFLICT DO NOTHING) : on n'applique l'effet sur "progressions" QUE pour une ligne
		-- reellement nouvelle - un renvoi apres coupure reseau ne double donc jamais l'effet.
		if v_deja_inseree then
			if v_type = 'gain_piece' then
				v_rarity := (v_payload->>'rarity');
				v_montant := (v_payload->>'montant')::int;
				update progressions set
					economy = jsonb_set(
						economy, array[v_rarity],
						to_jsonb(coalesce((economy->>v_rarity)::int, 0) + v_montant)
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'depense_piece' then
				v_rarity := (v_payload->>'rarity');
				v_montant := (v_payload->>'montant')::int;
				update progressions set
					economy = jsonb_set(
						economy, array[v_rarity],
						to_jsonb(greatest(coalesce((economy->>v_rarity)::int, 0) - v_montant, 0))
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'carte_debloquee' then
				v_card_id := (v_payload->>'card_id');
				update progressions set
					cards = jsonb_set(
						cards, array[v_card_id],
						to_jsonb(coalesce((cards->>v_card_id)::int, 0) + 1)
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'defi_reussi' then
				v_grade := (v_payload->>'grade');
				v_subject := (v_payload->>'subject');
				update progressions set
					defis = jsonb_set(
						coalesce(defis, '{}'::jsonb),
						array[v_grade],
						coalesce(defis->v_grade, '{}'::jsonb) || jsonb_build_object(v_subject, (v_payload->>'nouveau_total')::int)
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'achat_skin_prof' then
				v_grade := (v_payload->>'grade');
				update progressions set
					prof_skins = jsonb_set(
						jsonb_set(
							prof_skins, array['unlocked', v_grade],
							(
								select coalesce(jsonb_agg(distinct e), '[]'::jsonb)
								from (
									select jsonb_array_elements(coalesce(prof_skins->'unlocked'->v_grade, '[]'::jsonb)) as e
									union
									select to_jsonb((v_payload->>'skin_index')::int)
								) x
							)
						),
						array['active', v_grade],
						to_jsonb((v_payload->>'skin_index')::int)
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'skin_actif_change' then
				-- Reequipement gratuit d'un skin deja possede (pas d'unlock a toucher ici, contrairement
				-- a achat_skin_prof ci-dessus) - pas d'exclusivite entre classes pour les skins de prof
				-- (chaque classe a son propre skin actif independant, contrairement au decor/musique).
				v_grade := (v_payload->>'grade');
				update progressions set
					prof_skins = jsonb_set(
						prof_skins, array['active', v_grade], to_jsonb((v_payload->>'skin_index')::int)
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'decor_debloque' then
				v_grade := (v_payload->>'grade');
				update progressions set
					classroom_decor = jsonb_set(
						classroom_decor, array['unlocked', v_grade], 'true'::jsonb
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'decor_actif_change' then
				-- Un seul decor actif a la fois, toutes classes confondues (meme regle d'exclusivite que
				-- ClassroomDecor.toggle_active cote client) : si "actif" est vrai, on remet d'abord TOUTES
				-- les classes deja connues du sous-objet "active" a false avant de poser celle-ci a true -
				-- reproduit ici plutot que suppose deja coherent, au cas ou un autre appareil aurait
				-- active une autre classe pendant que celui-ci etait hors-ligne.
				v_grade := (v_payload->>'grade');
				v_actif := (v_payload->>'actif')::boolean;
				select coalesce(jsonb_object_agg(key, 'false'::jsonb), '{}'::jsonb) into v_active_reset
				from jsonb_object_keys(coalesce((select classroom_decor->'active' from progressions where compte_id = v_compte_id), '{}'::jsonb)) as key;
				if v_actif then
					update progressions set
						classroom_decor = jsonb_set(
							jsonb_set(classroom_decor, array['active'], v_active_reset),
							array['active', v_grade], 'true'::jsonb
						),
						maj_le = now()
					where compte_id = v_compte_id;
				else
					update progressions set
						classroom_decor = jsonb_set(
							classroom_decor, array['active', v_grade], 'false'::jsonb
						),
						maj_le = now()
					where compte_id = v_compte_id;
				end if;

			elsif v_type = 'musique_debloquee' then
				v_grade := (v_payload->>'grade');
				update progressions set
					classroom_music = jsonb_set(
						classroom_music, array['unlocked', v_grade], 'true'::jsonb
					),
					maj_le = now()
				where compte_id = v_compte_id;

			elsif v_type = 'musique_active_change' then
				-- Meme logique d'exclusivite que decor_actif_change ci-dessus, appliquee a
				-- classroom_music (deux ensembles independants : activer une musique ne touche jamais
				-- au decor actif, et inversement).
				v_grade := (v_payload->>'grade');
				v_actif := (v_payload->>'actif')::boolean;
				select coalesce(jsonb_object_agg(key, 'false'::jsonb), '{}'::jsonb) into v_active_reset
				from jsonb_object_keys(coalesce((select classroom_music->'active' from progressions where compte_id = v_compte_id), '{}'::jsonb)) as key;
				if v_actif then
					update progressions set
						classroom_music = jsonb_set(
							jsonb_set(classroom_music, array['active'], v_active_reset),
							array['active', v_grade], 'true'::jsonb
						),
						maj_le = now()
					where compte_id = v_compte_id;
				else
					update progressions set
						classroom_music = jsonb_set(
							classroom_music, array['active', v_grade], 'false'::jsonb
						),
						maj_le = now()
					where compte_id = v_compte_id;
				end if;

			elsif v_type = 'doublons_echanges' then
				-- Echange "10 doublons = 1 coffre" (2026-10-04, voir ShopPanel._do_duplicate_crate_purchase) :
				-- payload {"cards": {"<card_id>": <nombre retire>, ...}}. Meme regle que le client
				-- (CardCollection.consume_duplicates) : on ne descend jamais sous 1 exemplaire.
				-- La carte gagnee arrive a part, dans un evenement carte_debloquee normal.
				for v_doublon in select key, value from jsonb_each_text(coalesce(v_payload->'cards', '{}'::jsonb))
				loop
					update progressions set
						cards = jsonb_set(
							cards, array[v_doublon.key],
							to_jsonb(greatest(coalesce((cards->>v_doublon.key)::int, 0) - v_doublon.value::int, 1))
						),
						maj_le = now()
					where compte_id = v_compte_id and cards ? v_doublon.key;
				end loop;
			end if;

			v_ids_appliques := array_append(v_ids_appliques, v_id);
		end if;
	end loop;

	update progressions set dernier_evenement_id = v_ids_appliques[array_length(v_ids_appliques, 1)]
	where compte_id = v_compte_id and array_length(v_ids_appliques, 1) > 0;

	return jsonb_build_object('ids_appliques', to_jsonb(v_ids_appliques));
end;
$function$;
