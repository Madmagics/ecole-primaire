shader_type spatial;
render_mode cull_disabled, diffuse_lambert, specular_schlick_ggx;

// Lightweight foliage wind sway.
// The whole surface is rotated as ONE rigid body around the local origin
// (small angle around X and Z) instead of offsetting vertices by height,
// so leaf/petal shapes never stretch or shear - only the whole mesh tilts.
// Fully GPU-driven via TIME, zero per-frame CPU cost.

uniform sampler2D albedo_texture : source_color, filter_nearest;
uniform float alpha_scissor_threshold : hint_range(0.0, 1.0) = 0.3;
uniform float wind_speed : hint_range(0.0, 5.0) = 1.5;
uniform float wind_angle_degrees : hint_range(0.0, 20.0) = 4.0;

void vertex() {
	float phase = dot(NODE_POSITION_WORLD.xz, vec2(0.63, 0.91));
	float t = TIME * wind_speed + phase;
	float angle_z = radians(wind_angle_degrees) * sin(t);
	float angle_x = radians(wind_angle_degrees) * 0.6 * sin(t * 0.8 + 1.7);

	float cz = cos(angle_z);
	float sz = sin(angle_z);
	mat3 rot_z = mat3(
		vec3(cz, sz, 0.0),
		vec3(-sz, cz, 0.0),
		vec3(0.0, 0.0, 1.0)
	);

	float cx = cos(angle_x);
	float sx = sin(angle_x);
	mat3 rot_x = mat3(
		vec3(1.0, 0.0, 0.0),
		vec3(0.0, cx, sx),
		vec3(0.0, -sx, cx)
	);

	mat3 rot = rot_x * rot_z;
	VERTEX = rot * VERTEX;
	NORMAL = normalize(rot * NORMAL);
}

void fragment() {
	vec4 tex = texture(albedo_texture, UV);
	ALBEDO = tex.rgb;
	ALPHA = tex.a;
	ALPHA_SCISSOR_THRESHOLD = alpha_scissor_threshold;
	ROUGHNESS = 0.6;
}
