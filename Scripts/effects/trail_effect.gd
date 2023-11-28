extends Line2D

var stored_points: Array
@export var tracked_object: Node2D
@export var MAX_LENGTH: int
@export var fever_gradiant: Gradient
@export var normal_gradiant: Gradient

func _physics_process(_delta: float) -> void:
	if stored_points.size() > MAX_LENGTH:
		_remove_trail_tail()
		
	if tracked_object != null:
		_append_trail_head(tracked_object.global_position)

func _remove_trail_tail():
	stored_points.pop_front()
	remove_point(0)


func _append_trail_head(pos: Vector2):
	stored_points.append(pos)
	add_point(pos)


func _ready():
	reparent(get_tree().root, false)
	global_position = Vector2.ZERO
	if VarManager.get_data(Varkey.B_IS_FEVER):
		gradient = fever_gradiant
	else:
		gradient = normal_gradiant
