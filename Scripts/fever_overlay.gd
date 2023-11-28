extends Node


func _ready():
	VarManager.on_data_changed.connect(_on_var_changed)
	_on_fever_changed(VarManager.get_data(Varkey.B_IS_FEVER))


func _on_var_changed(path: String, new_val, old_val):
	if path == Varkey.B_IS_FEVER:
		_on_fever_changed(new_val)


func _on_fever_changed(new_fever: bool):
	self.visible = new_fever
