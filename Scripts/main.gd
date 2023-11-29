extends Node2D

func _ready():
	VarManager.on_data_changed.connect(_on_var_changed)


func _on_var_changed(path: String, new_val, old_val):
	if path == Varkey.B_IS_ENDING:
		_ending()

func _ending():
	# show popup
	pass
