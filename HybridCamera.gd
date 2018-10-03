extends Camera

enum CameraMode {FirstPerson, ThirdPerson}

export (CameraMode) var camera_mode = ThirdPerson setget set_camera_mode, get_camera_mode;

export (Vector3) var tp_offset = Vector3(0,0,5);

export (bool) var tp_x_inverted = false;
export (bool) var tp_y_inverted = false;
export (bool) var fp_x_inverted = false;
export (bool) var fp_y_inverted = false;

export (Vector2) var tp_sensitivity = Vector2(0.2,0.2);
export (Vector2) var fp_sensitivity = Vector2(0.2,0.2);

func set_camera_mode(value):
	camera_mode = value;
	if value == FirstPerson:
		self.cull_mask = 1048573; #11111111111111111101
		self.transform.origin = Vector3(0,0,0);
	elif value == ThirdPerson:
		self.cull_mask = 1048571; #11111111111111111011
		self.transform.origin = tp_offset;

func _ready():
	set_camera_mode(camera_mode);

func get_camera_mode():
	return camera_mode;

func toggle_camera_mode():
	set_camera_mode(FirstPerson if camera_mode == ThirdPerson else ThirdPerson);

func _process(delta):
	if Input.is_action_just_pressed("toggle_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if Input.get_mouse_mode() != Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_CAPTURED);
	if Input.is_action_just_pressed("toggle_camera_mode"):
		toggle_camera_mode();

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var _mouse_delta = event.relative;

		if camera_mode == ThirdPerson:
			_mouse_delta = -_mouse_delta;
			if tp_x_inverted:
				_mouse_delta.x = -_mouse_delta.x;
			if tp_y_inverted:
				_mouse_delta.y = -_mouse_delta.y;
			_mouse_delta *= tp_sensitivity;
		else:
			if not fp_x_inverted:
				_mouse_delta.x = -_mouse_delta.x;
			if not tp_y_inverted:
				_mouse_delta.y = -_mouse_delta.y;
			_mouse_delta *= fp_sensitivity;

		var rot_deg = get_parent().rotation_degrees + Vector3(_mouse_delta.y, _mouse_delta.x, 0);
		rot_deg.x = clamp(rot_deg.x, -89, 89);
		get_parent().rotation_degrees = rot_deg;
