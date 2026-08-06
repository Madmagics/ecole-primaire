@tool
extends Node3D
## Attaches a lightweight wind-sway ShaderMaterial to descendant mesh surfaces.
## Pure rigid rotation in the shader (see wind_sway.gdshader) so leaves/petals
## never stretch. Runs once in _ready(); the animation itself is TIME-driven
## on the GPU, so there is no per-frame cost from this script.
##
## Attached to the root of an instanced glTF model, which Godot's importer
## wraps in a plain Node3D even when the source has a single mesh node - the
## actual MeshInstance3D is a child, hence the recursive search below.

const WIND_SHADER: Shader = preload("res://entities/decor/wind_sway.gdshader")

@export var wind_speed: float = 1.5
@export_range(0.0, 20.0) var wind_angle_degrees: float = 4.0
## Surface indices to leave untouched, e.g. [0] to skip a tree's bark surface.
@export var skip_surfaces: Array[int] = []

func _ready() -> void:
	_apply_wind(self)

func _apply_wind(node: Node) -> void:
	for child in node.get_children():
		if child is MeshInstance3D:
			_apply_to_mesh(child)
		_apply_wind(child)

func _apply_to_mesh(mesh_instance: MeshInstance3D) -> void:
	if mesh_instance.mesh == null:
		return
	for surface_idx in mesh_instance.mesh.get_surface_count():
		if surface_idx in skip_surfaces:
			continue
		var original: Material = mesh_instance.get_active_material(surface_idx)
		var shader_mat := ShaderMaterial.new()
		shader_mat.shader = WIND_SHADER
		shader_mat.set_shader_parameter("wind_speed", wind_speed)
		shader_mat.set_shader_parameter("wind_angle_degrees", wind_angle_degrees)
		if original is BaseMaterial3D:
			shader_mat.set_shader_parameter("albedo_texture", (original as BaseMaterial3D).albedo_texture)
		mesh_instance.set_surface_override_material(surface_idx, shader_mat)
