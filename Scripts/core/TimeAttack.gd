extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var is_paused = VarManager.get_data(Varkey.B_IS_PAUSED)
	var is_ending = VarManager.get_data(Varkey.B_IS_ENDING)
	if is_paused or is_ending: return
	var current = VarManager.get_data(Varkey.F_TIMER_VAL)
	VarManager.set_data(Varkey.F_TIMER_VAL, clampf(current - delta, 0, GameConst.F_TIMEOUT))
	if (current <= 0):
		VarManager.set_data(Varkey.B_IS_ENDING, true)
	if VarManager.get_data(Varkey.B_IS_FEVER):
		var new_fever = max(0.0, VarManager.get_data(Varkey.F_FEVER_VAL) - (GameConst.F_FEVER_LOSS_RATE * delta))
		VarManager.set_data(Varkey.F_FEVER_VAL, new_fever)
		if new_fever <= 0.0:
			VarManager.set_data(Varkey.B_IS_FEVER, false)
			VarManager.set_data(Varkey.I_FISH_FEVER_COUNT, 1)
