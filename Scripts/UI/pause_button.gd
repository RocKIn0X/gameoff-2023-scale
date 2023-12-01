extends TextureButton

func _ready():
	hide()
	VarManager.on_data_changed.connect(_on_data_changed)

func _on_data_changed(key, new_val, old_val):
	if key == Varkey.B_IS_ENDING:
		if !new_val: show()
		else: hide()

func _on_toggled(button_pressed):
	VarManager.set_data(Varkey.B_IS_PAUSED, button_pressed);
