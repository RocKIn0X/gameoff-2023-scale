extends Node2D

signal on_timeout;

@export var timeout: float;
@export var progress_bar: TextureProgressBar;

var current: float
var is_running = false

func _ready():
	current = timeout;
	_start();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_running: return
	print(current)
	current -= delta
	current = clampf(current, 0, timeout)
	_update_bar();
	if (current <= 0):
		_set_running(false)
		on_timeout.emit()

func _start():
	is_running = true
	current = timeout
	_update_bar();

func _set_running(running):
	is_running = running

func _update_bar():
	progress_bar.value = (current / timeout) * progress_bar.max_value;
	print(progress_bar.value)
