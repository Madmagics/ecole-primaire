-- ============================================================================
-- Migration 2026-09-15 : repli captcha desktop/mobile (code court à retaper), voir
-- project_auth_creation_comptes.md. À exécuter UNE FOIS dans Supabase Studio > SQL Editor.
-- Sans danger sur la base en production : aucun "drop table" avec perte de données, seulement des
-- ajouts (table + fonction) et le remplacement de la logique interne de fn_creer_compte_public
-- (le "drop function" ci-dessous ne supprime QUE la définition de l'ancienne fonction, pas de
-- données - les fonctions ne contiennent jamais de données).
-- ============================================================================

-- 8. defis_captcha — code court (6 caractères) à usage unique prouvant qu'un token Turnstile
-- valide a déjà été vérifié, pour les plateformes desktop/mobile où le client Godot n'a aucun
-- moteur JS pour afficher le widget Turnstile lui-même. Parcours : une page web (captcha.html, sur
-- le domaine du jeu, ouverte dans le navigateur système via OS.shell_open) affiche le widget
-- Turnstile, envoie le token obtenu à fn_verifier_turnstile_creer_code ci-dessous, affiche le code
-- renvoyé - l'enfant/le parent le retape dans le jeu, qui l'envoie à fn_creer_compte_public
-- (paramètre p_code_captcha) à la place d'un token direct. Seul le HACHÉ du code est stocké, même
-- logique que mdp_hash/token_hash - un accès en lecture à cette table ne permet donc pas d'utiliser
-- un code à la place de son destinataire réel.
create table if not exists defis_captcha (
	code_hash    text primary key,
	expire_le    timestamptz not null,
	utilise      boolean not null default false
);
create index if not exists defis_captcha_expire_le_idx on defis_captcha (expire_le);
alter table defis_captcha enable row level security;

-- p_code_captcha (repli desktop/mobile) : si fourni (non vide), remplace p_turnstile_token -
-- vérifié contre defis_captcha au lieu d'un appel direct à Cloudflare. Signature changée par
-- rapport à la version du 2026-09-14 : drop explicite ci-dessous (create or replace ne suffit pas
-- quand la liste de paramètres change, ça créerait une 2e fonction en doublon au lieu de
-- remplacer).
drop function if exists fn_creer_compte_public(text, text, text, text, jsonb, text, text, text);

create or replace function fn_creer_compte_public(
	p_id text,
	p_login text,
	p_mdp_hash text,
	p_mdp_sel text,
	p_profil jsonb,
	p_email text,
	p_turnstile_token text default '',
	p_code_captcha text default '',
	p_honeypot text default ''
)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_ip                text;
	v_cle_ip            text;
	v_cle_email         text;
	v_nb_tentatives      int;
	v_turnstile_secret   text;
	v_reponse_turnstile  http_response;
	v_captcha_ok         boolean;
	v_resultat           jsonb;
	v_compte_id          text;
	v_email              text := nullif(trim(p_email), '');
	v_token              text;
	v_brevo_ok           boolean := false;
begin
	-- Honeypot : un vrai enfant/parent ne remplit jamais ce champ (caché en CSS côté formulaire) -
	-- un bot qui remplit tous les champs du formulaire, si. Rejet générique, même message qu'un
	-- captcha invalide - ne pas donner d'indice à un bot sur la raison précise du refus.
	if p_honeypot is not null and p_honeypot <> '' then
		raise exception 'captcha_invalide';
	end if;

	begin
		v_ip := (current_setting('request.headers', true)::jsonb ->> 'x-forwarded-for');
	exception when others then
		v_ip := null;
	end;

	-- Purge paresseuse (voir commentaire de la table).
	delete from creations_recentes where horodatage < now() - interval '10 minutes';

	v_cle_ip := 'ip:' || coalesce(v_ip, '');
	v_cle_email := 'email:' || lower(coalesce(v_email, ''));

	if v_ip is not null then
		select count(*) into v_nb_tentatives from creations_recentes
		where cle = v_cle_ip and horodatage > now() - interval '1 minute';
		if v_nb_tentatives >= 5 then
			raise exception 'trop_de_creations';
		end if;
	end if;
	if v_email is not null then
		select count(*) into v_nb_tentatives from creations_recentes
		where cle = v_cle_email and horodatage > now() - interval '1 minute';
		if v_nb_tentatives >= 5 then
			raise exception 'trop_de_creations';
		end if;
	end if;

	if p_code_captcha is not null and p_code_captcha <> '' then
		-- Repli desktop/mobile (voir commentaire de defis_captcha) : le code vient de captcha.html,
		-- déjà vérifié auprès de Cloudflare par fn_verifier_turnstile_creer_code à sa génération -
		-- ici on vérifie seulement qu'il existe, n'a pas expiré, et pas déjà été utilisé (usage
		-- unique, comme un token Turnstile). upper()/trim() : le code affiché est tout en
		-- majuscules, insensible à la casse à la retape pour ne pas ajouter de friction inutile.
		delete from defis_captcha where expire_le < now();
		update defis_captcha
			set utilise = true
			where code_hash = encode(digest(upper(trim(p_code_captcha)), 'sha256'), 'hex')
				and not utilise
				and expire_le > now()
			returning true into v_captcha_ok;
		v_captcha_ok := coalesce(v_captcha_ok, false);
	else
		-- Plateforme Web : widget Turnstile affiché directement dans la page, vérification classique.
		select valeur into v_turnstile_secret from config_secrets where cle = 'turnstile_secret_key';
		if v_turnstile_secret is null then
			raise exception 'captcha_non_configure';
		end if;

		select * into v_reponse_turnstile from http_post(
			'https://challenges.cloudflare.com/turnstile/v0/siteverify',
			jsonb_build_object('secret', v_turnstile_secret, 'response', p_turnstile_token)::text,
			'application/json'
		);
		v_captcha_ok := coalesce((v_reponse_turnstile.content::jsonb ->> 'success')::boolean, false);
	end if;

	if not v_captcha_ok then
		raise exception 'captcha_invalide';
	end if;

	-- Enregistré seulement maintenant (captcha validé) : fait partie du chemin de succès, ne sera
	-- donc jamais annulé par un échec ultérieur - ne compte que les tentatives réellement humaines.
	insert into creations_recentes (cle) values (v_cle_ip);
	if v_email is not null then
		insert into creations_recentes (cle) values (v_cle_email);
	end if;

	-- Création proprement dite : réutilise fn_creer_compte (idempotence sur l'id, gestion de
	-- collision de login déjà gérées là-bas, pas de raison de dupliquer cette logique ici).
	select fn_creer_compte(p_id, p_login, p_mdp_hash, p_mdp_sel, p_profil) into v_resultat;
	v_compte_id := v_resultat ->> 'id';

	if v_email is not null then
		update comptes set email = v_email, email_verifie = false where id = v_compte_id;

		v_token := encode(gen_random_bytes(32), 'hex');
		insert into verifications_email (compte_id, token_hash, expire_le, dernier_envoi_le)
		values (v_compte_id, encode(digest(v_token, 'sha256'), 'hex'), now() + interval '24 hours', now())
		on conflict (compte_id) do update
			set token_hash = excluded.token_hash,
			    expire_le = excluded.expire_le,
			    dernier_envoi_le = excluded.dernier_envoi_le;

		begin
			v_brevo_ok := fn_envoyer_email_verification(v_email, v_token);
		exception when others then
			v_brevo_ok := false;
		end;
	end if;

	return jsonb_build_object(
		'id', v_compte_id,
		'login', v_resultat ->> 'login',
		'email_envoye', v_brevo_ok
	);
end;
$$;

-- fn_verifier_turnstile_creer_code : point d'entrée de captcha.html (plateformes desktop/mobile).
-- Vérifie le token Turnstile auprès de Cloudflare (même appel que la branche Web de
-- fn_creer_compte_public) puis génère un code court à usage unique que l'utilisateur retape dans
-- le jeu. Callable anonymement (PAS de revoke comme fn_envoyer_email_verification) : la preuve
-- d'humanité, c'est le token Turnstile lui-même, pas une session - et cette fonction n'envoie
-- aucun email/n'a aucun effet en dehors d'un code éphémère sans valeur hors d'une création de
-- compte dans les 10 minutes qui suivent, donc aucun abus de relais possible ici.
create or replace function fn_verifier_turnstile_creer_code(p_turnstile_token text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
	v_turnstile_secret   text;
	v_reponse_turnstile  http_response;
	v_captcha_ok         boolean;
	v_code               text;
	-- Sans 0/O/1/I/L : caractères ambigus à l'oral/à l'écrit pour un enfant qui doit les retaper.
	v_alphabet           text := 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
begin
	select valeur into v_turnstile_secret from config_secrets where cle = 'turnstile_secret_key';
	if v_turnstile_secret is null then
		raise exception 'captcha_non_configure';
	end if;

	select * into v_reponse_turnstile from http_post(
		'https://challenges.cloudflare.com/turnstile/v0/siteverify',
		jsonb_build_object('secret', v_turnstile_secret, 'response', p_turnstile_token)::text,
		'application/json'
	);
	v_captcha_ok := coalesce((v_reponse_turnstile.content::jsonb ->> 'success')::boolean, false);
	if not v_captcha_ok then
		raise exception 'captcha_invalide';
	end if;

	-- Purge paresseuse (même principe que creations_recentes) avant d'insérer le nouveau code.
	delete from defis_captcha where expire_le < now();

	v_code := array_to_string(array(
		select substr(v_alphabet, (random() * length(v_alphabet))::int + 1, 1)
		from generate_series(1, 6)
	), '');

	insert into defis_captcha (code_hash, expire_le)
	values (encode(digest(v_code, 'sha256'), 'hex'), now() + interval '10 minutes');

	return jsonb_build_object('code', v_code);
end;
$$;
