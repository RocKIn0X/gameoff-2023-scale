extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	VarManager.on_data_changed.connect(_on_data_changed)

func _on_data_changed(key, new_data, old_data):
	if key == Varkey.F_TIMER_VAL:
		_update_bar(new_data)

func _update_bar(current):
	value = (current / GameConst.F_TIMEOUT) * max_value;
