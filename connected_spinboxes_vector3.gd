extends VBoxContainer

export (Vector3) var value = Vector3() setget set_value, get_value;

signal value_changed(new_value);

func set_value(val):
	value = val;
	if not $X/SpinBox:
		return;
	$X/SpinBox.value = val.x;
	$Y/SpinBox.value = val.y;
	$Z/SpinBox.value = val.z;

func get_value():
	return Vector3($X/SpinBox.value, $Y/SpinBox.value, $Z/SpinBox.value);

func _ready():
	$X/SpinBox.connect("value_changed", self, "subval_changed");
	$Y/SpinBox.connect("value_changed", self, "subval_changed");
	$Z/SpinBox.connect("value_changed", self, "subval_changed");
	$X/SpinBox.value = value.x;
	$Y/SpinBox.value = value.y;
	$Z/SpinBox.value = value.z;

func subval_changed(newval):
	emit_signal("value_changed", get_value());
