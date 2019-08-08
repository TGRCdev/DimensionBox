extends HBoxContainer

func spin_box_text_entered(text):
	get_focus_owner().release_focus();
	$HSlider.value = float(text);

func slider_value_changed(value):
	$SpinBox.value = value;

func _ready():
	$HSlider.connect("value_changed", self, "slider_value_changed");
	$SpinBox.get_line_edit().connect("text_entered", self, "spin_box_text_entered");
	$HSlider.value = $SpinBox.value;
