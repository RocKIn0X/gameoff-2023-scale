extends Node
@export var gauge_line: Line2D
@export var gauge_normal_color: Color
@export var gauge_mid_color: Color
@export var gauge_low_color: Color


func _ready():
	VarManager.on_data_changed.connect(_on_var_changed)
	_on_fever_changed(VarManager.get_data(Varkey.F_FEVER_VAL))


func _on_var_changed(path: String, new_val, old_val):
	if path == Varkey.F_FEVER_VAL:
		_on_fever_changed(new_val)


func _on_fever_changed(new_fever: float):
	gauge_line.points[1].y = (new_fever * -4) + 0.1
	var percent_fever = new_fever / GameConst.F_FEVER_MAX
	if percent_fever > 0.5:
		gauge_line.default_color = gauge_normal_color
	elif percent_fever > 0.1:
		gauge_line.default_color = gauge_mid_color
	else:
		gauge_line.default_color = gauge_low_color
