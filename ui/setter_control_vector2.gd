extends HBoxContainer

class_name SetterControlVector2

var vector2_value:Vector2

signal value_changed(vector2:Vector2)

func set_vector2(new_vector2_value:Vector2):
	vector2_value = new_vector2_value

func on_x_changed(float_value:float):
	vector2_value.x = float_value
	value_changed.emit(vector2_value)

func on_y_changed(float_value:float):
	vector2_value.y = float_value
	value_changed.emit(vector2_value)
