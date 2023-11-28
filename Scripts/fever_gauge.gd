extends TextureProgressBar

func _ready():
	VarManager.on_data_changed.connect(_on_var_changed)
	_on_fever_changed(VarManager.get_data(Varkey.F_FEVER_VAL))


func _on_var_changed(path: String, new_val, old_val):
	if path == Varkey.F_FEVER_VAL:
		_on_fever_changed(new_val)


func _on_fever_changed(new_fever: float):
	value = (new_fever / GameConst.F_FEVER_MAX) * max_value;
