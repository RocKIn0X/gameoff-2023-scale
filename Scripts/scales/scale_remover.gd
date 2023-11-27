extends Area2D

@export var normal: Texture2D;
@export var broken: Texture2D;

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN;
	VarManager.on_data_changed.connect(_on_data_changed)

func _process(delta):
	global_position = get_viewport().get_mouse_position();

func _on_data_changed(key, new_data, old_data):
	if key == Varkey.F_SHARPNESS_VAL:
		_update_texture(new_data <= 0)
		
func _update_texture(is_broken):
	if is_broken: $Sprite2D.texture = broken
	else: $Sprite2D.texture = normal
