extends KinematicBody

export (float) var speed = 5;
export (Vector3) var gravity = Vector3(0, -9.8, 0);
export (float) var jump_height = 5;

var velocity = Vector3();

func get_head():
	return $Head;

func get_head_transform():
	return get_head().transform;

func get_head_global_transform():
	return get_head().global_transform;

func get_camera():
	return $Head/HybridCamera;

func get_camera_transform():
	return get_camera().transform;

func get_camera_global_transform():
	return get_camera().global_transform;

var _jump_pressed = false;

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		_jump_pressed = true;

func _physics_process(delta):
	var direction = Vector3();
	var basic_direction = Vector3();
	var forward = -$Head.global_transform.basis.z;
	forward.y = 0;
	forward = forward.normalized();
	var right = $Head.global_transform.basis.x.normalized();
	if Input.is_action_pressed("move_left"):
		basic_direction.x -= 1;
		direction += -right;
	if Input.is_action_pressed("move_right"):
		basic_direction.x += 1;
		direction += right;
	if Input.is_action_pressed("move_forward"):
		basic_direction.z -= 1;
		direction += forward;
	if Input.is_action_pressed("move_backward"):
		basic_direction.z += 1;
		direction += -forward;
	basic_direction = basic_direction.normalized();
	direction = direction.normalized() * speed;

	velocity += gravity * delta;
	velocity.x = direction.x;
	velocity.z = direction.z;

	if is_on_floor():
		if _jump_pressed:
			velocity += -gravity.normalized() * jump_height;

	velocity = move_and_slide(velocity, -gravity.normalized());

	var slide_count = get_slide_count();
	if slide_count > 0:
		var idx = 0;
		while idx < slide_count:
			var collision = get_slide_collision(idx);
			if collision.collider is RigidBody:
				collision.collider.apply_impulse(collision.position, direction.normalized());
			idx += 1;
	_jump_pressed = false;