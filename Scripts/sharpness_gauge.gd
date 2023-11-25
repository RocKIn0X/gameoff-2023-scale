extends Node
@export var gauge_line: Line2D

func _ready():
	VarManager.on_data_changed.connect(_on_var_changed)


func _on_var_changed(path: String, new_val, old_val):
	if path == Varkey.F_SHARPNESS_VAL:
		_on_sharpness_changed(new_val)


func _on_sharpness_changed(new_sharpness: float):
	print(new_sharpness)
	gauge_line.points[1].y = new_sharpness * -4
