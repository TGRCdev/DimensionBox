extends Spatial

export (Vector3) var rotation_speed = Vector3(0, 50, 0);
export (Vector3) var move_speed = Vector3(1,0,0);

func _process(delta):
	translation += move_speed * delta;
	rotation_degrees += rotation_speed * delta;