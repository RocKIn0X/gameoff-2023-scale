extends Node
@export var gauge_line: Line2D
@export var gauge_normal_color: Color
@export var gauge_mid_color: Color
@export var gauge_low_color: Color


func _ready():
	VarManager.on_data_changed.connect(_on_var_changed)


func _on_var_changed(path: String, new_val, old_val):
	if path == Varkey.F_SHARPNESS_VAL:
		_on_sharpness_changed(new_val)


func _on_sharpness_changed(new_sharpness: float):
	gauge_line.points[1].y = (new_sharpness * -4) + 0.1
	var percent_sharpness = new_sharpness / GameCalculation.get_max_sharpness()
	if percent_sharpness > 0.5:
		gauge_line.default_color = gauge_normal_color
	elif percent_sharpness > 0.1:
		gauge_line.default_color = gauge_mid_color
	else:
		gauge_line.default_color = gauge_low_color
