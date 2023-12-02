extends Node

@export var count_text: Label;

func _ready():
	VarManager.on_data_changed.connect(_on_var_changed)
	_on_fever_changed(VarManager.get_data(Varkey.B_IS_FEVER))
	_on_fish_changed(VarManager.get_data(Varkey.I_FISH_FEVER_COUNT))


func _on_var_changed(path: String, new_val, old_val):
	if path == Varkey.B_IS_FEVER:
		_on_fever_changed(new_val)
	if path == Varkey.I_FISH_FEVER_COUNT:
		_on_fish_changed(new_val)

func _on_fever_changed(new_fever: bool):
	self.visible = new_fever

func _on_fish_changed(new_count: int):
	count_text.text = "x%s" % new_count
