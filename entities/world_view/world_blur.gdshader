// Flou applique au rendu du monde 3D (voir world_view_blur.gd), pensee pour le renderer
// Compatibility de ce projet (renderer/rendering_method="gl_compatibility" dans project.godot) :
// on lit uniquement TEXTURE, la texture propre a ce noeud (le SubViewport parent, voir
// docs.godotengine.org "Using a SubViewport as a texture"), jamais SCREEN_TEXTURE /
// hint_screen_texture. Ce dernier a des bugs connus specifiques au renderer Compatibility
// (godotengine/godot#97728, #106787 : filtrage, ecran noir au redimensionnement) - on les
// evite entierement en ne dependant que d'une texture normale, ce qui fonctionne de la meme
// facon sur les trois renderers Godot 4.
shader_type canvas_item;

// 0.0 = image nette (aucun flou). Augmente = flou plus fort. Piloté depuis world_view_blur.gd.
uniform float blur_amount : hint_range(0.0, 10.0) = 0.0;

void fragment() {
	vec2 px = TEXTURE_PIXEL_SIZE * blur_amount;
	vec4 sum = texture(TEXTURE, UV) * 4.0;
	sum += texture(TEXTURE, UV + vec2(px.x, 0.0));
	sum += texture(TEXTURE, UV - vec2(px.x, 0.0));
	sum += texture(TEXTURE, UV + vec2(0.0, px.y));
	sum += texture(TEXTURE, UV - vec2(0.0, px.y));
	sum += texture(TEXTURE, UV + px);
	sum += texture(TEXTURE, UV - px);
	sum += texture(TEXTURE, UV + vec2(px.x, -px.y));
	sum += texture(TEXTURE, UV + vec2(-px.x, px.y));
	COLOR = sum / 12.0;
}
