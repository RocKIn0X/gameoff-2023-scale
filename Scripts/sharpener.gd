extends Node2D

const SHARPNESS_KEY = Varkey.F_SHARPNESS_VAL

@onready var _is_tracking := false
@onready var _cursor_pos := Vector2.ONE * -1

@export var hitbox: CollisionObject2D
@export var animated: AnimatedSprite2D

var is_playing_sfx = false

func _ready():
	hitbox.mouse_entered.connect(_on_mouse_entered)
	hitbox.mouse_exited.connect(_on_mouse_left)
	animated.play("default")
	#Debug.set_sharpness(0.0)

func _on_mouse_entered():
	_is_tracking = true

func _on_mouse_left():
	_cursor_pos = Vector2.ONE * -1
	_is_tracking = false

func _physics_process(delta):
	if not _is_tracking:
		return
	var current_cursor_pos = get_viewport().get_mouse_position();
	var y_diff = (current_cursor_pos - _cursor_pos).y
	_cursor_pos = current_cursor_pos
	if y_diff >= 0: # minus y = higher in screen pos
		return
	var sharpness = VarManager.get_data(SHARPNESS_KEY)
	var max_sharpness = GameCalculation.get_max_sharpness()
	if sharpness >= max_sharpness:
		return
	var sharpen_rate = GameCalculation.get_sharpness_increase_rate()
	var increase = sharpen_rate * delta * abs(y_diff)
	if increase < 0:
		return
	var new_sharpness = min(sharpness + increase, max_sharpness)
	VarManager.set_data(SHARPNESS_KEY, new_sharpness)
	_play_sfx()


func _on_button_pressed(sharpness: float):
	Debug.set_sharpness(sharpness)

func _play_sfx():
	if is_playing_sfx: return
	is_playing_sfx = true
	$AudioStreamPlayer2D.play()
	$AudioStreamPlayer2D.finished.connect(func(): is_playing_sfx = false)
