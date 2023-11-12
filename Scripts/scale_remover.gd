extends Area2D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN;

func _process(delta):
	global_position = get_viewport().get_mouse_position();
