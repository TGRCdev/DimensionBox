extends Viewport

onready var camera = get_camera();

export (float, 0.1, 10) var world_scale = 1 setget set_world_scale, get_world_scale;

func set_world_scale(val):
	world_scale = val;

func get_world_scale():
	return world_scale;

func _ready():
	size = get_parent().get_viewport().size;
	var texture = get_texture();
	texture.flags = Texture.FLAG_FILTER | Texture.FLAG_CONVERT_TO_LINEAR;
	get_parent().get_node("Cube/Faces").get_surface_material(0).set_shader_param("viewport_texture", texture);
	#get_parent().get_surface_material(0).set_shader_param("viewport_texture", texture);
	#print(get_parent().get_surface_material(0).get_shader_param("viewport_texture").flags);
	get_parent().get_viewport().connect("size_changed", self, "size_changed");

func _process(delta):
	var parent_camera = get_parent().get_viewport().get_camera();
	$Root/CameraPivot.transform.basis = get_parent().transform.basis.inverse();
	camera.rotation = parent_camera.rotation;
	camera.translation = (parent_camera.translation - get_parent().translation) / world_scale;

func size_changed():
	self.size = get_parent().get_viewport().size;
