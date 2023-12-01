extends TextureButton

func _on_toggled(button_pressed):
	VarManager.set_data(Varkey.B_IS_PAUSED, button_pressed);
