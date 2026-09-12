shader_type canvas_item;

// Fond de GameMenuPanel (2026-08-25) : floute ce qu'il y a derriere puis applique une teinte
// plate ("mono", plus de degrade) par dessus - remplace le degrade noir 80%->20% utilise dans la
// toute premiere version (retour utilisateur : "la bande transparente devient mono 10% et
// floutage de l'image arriere 20%"). Applique initialement seulement sur la bande d'icones
// (IconDock), puis etendu a tout l'ecran le meme jour (retour utilisateur : "applique la flou sur
// toute la fenetre quand le menu est actif") - voir le node BlurBG en enfant direct de
// GameMenuPanel (derriere Panel et IconDock) dans game_menu_panel.tscn, plus de BlurBG local a
// IconDock (redondant).
//
// Technique du flou : lire hint_screen_texture a un niveau de mipmap superieur a 0 via
// textureLod - Godot calcule alors automatiquement une version floutee de l'ecran, sans ecrire de
// flou manuel a base d'echantillons multiples (voir docs.godotengine.org/en/4.7/tutorials/
// shaders/screen-reading_shaders.html, section "Screen texture" : "If you want to read from a
// blurred version of the texture instead, you can increase the third argument to textureLod").
// filter_nearest_mipmap est le hint requis pour que Godot genere cette chaine de mipmaps.
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest_mipmap;

// Niveau de mipmap lu (0 = net, plus haut = plus flou). Pas une unite physique standard : expose
// en uniform pour pouvoir ajuster "a l'oeil" dans l'inspecteur sans retoucher le shader - valeur
// de depart choisie comme interpretation raisonnable de "floutage 20%" sur une plage utile
// d'environ 0 a 8 (voir shader_parameter/blur_amount dans game_menu_panel.tscn).
uniform float blur_amount : hint_range(0.0, 8.0) = 2.0;

// Teinte plate appliquee par dessus le flou - remplace le degrade noir 80%->20% : noir a 10%
// d'opacite ("mono 10%", retour utilisateur), uniforme sur toute la bande.
uniform vec4 tint_color : source_color = vec4(0.0, 0.0, 0.0, 0.1);

void fragment() {
	vec3 blurred = textureLod(screen_texture, SCREEN_UV, blur_amount).rgb;
	COLOR.rgb = mix(blurred, tint_color.rgb, tint_color.a);
	COLOR.a = 1.0;
}
