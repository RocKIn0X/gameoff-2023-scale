extends Node2D

signal on_timeout;

var current: float
var is_running = false

func _ready():
	_start();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_running: return
	var current = VarManager.get_data(Varkey.F_TIMER_VAL)
	VarManager.set_data(Varkey.F_TIMER_VAL, clampf(current - delta, 0, GameConst.F_TIMEOUT))
	if (current <= 0):
		_set_running(false)
		on_timeout.emit()
	if VarManager.get_data(Varkey.B_IS_FEVER):
		var new_fever = max(0.0, VarManager.get_data(Varkey.F_FEVER_VAL) - (GameConst.F_FEVER_LOSS_RATE * delta))
		VarManager.set_data(Varkey.F_FEVER_VAL, new_fever)
		if new_fever <= 0.0:
			VarManager.set_data(Varkey.B_IS_FEVER, false)

func _start():
	is_running = true

func _set_running(running):
	is_running = running
