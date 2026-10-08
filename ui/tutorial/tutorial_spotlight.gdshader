// Voile noir du tutoriel avec un trou circulaire (cercle de mise en valeur) - voir
// tutorial_spotlight.gd. Coordonnees en pixels du rectangle (UV * rect_size).
shader_type canvas_item;

uniform vec2 rect_size = vec2(1152.0, 648.0);
uniform vec2 hole_center = vec2(0.0, 0.0);
uniform float hole_radius = 0.0;
uniform bool has_hole = false;
uniform float dim_alpha = 0.5;
uniform vec4 ring_color : source_color = vec4(1.0, 0.85, 0.2, 1.0);
uniform float ring_width = 5.0;

void fragment() {
	vec2 p = UV * rect_size;
	float d = distance(p, hole_center);
	// Leger battement de l'anneau (+/-4 %) pour attirer l'oeil sur la cible.
	float r = hole_radius * (1.0 + 0.04 * sin(TIME * 4.0));
	float outside = has_hole ? smoothstep(r - 1.5, r + 1.5, d) : 1.0;
	float ring = has_hole ? 1.0 - smoothstep(ring_width * 0.5 - 1.0, ring_width * 0.5 + 1.0, abs(d - r)) : 0.0;
	vec4 dim = vec4(0.0, 0.0, 0.0, dim_alpha * outside);
	COLOR = mix(dim, ring_color, ring);
}
