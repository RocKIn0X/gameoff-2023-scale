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
	VarManager.on_data_changed.connect(_on_var_changed)
	_on_fever_changed(VarManager.get_data(Varkey.B_IS_FEVER))


func _on_var_changed(path: String, new_val, old_val):
	if path == Varkey.B_IS_FEVER:
		_on_fever_changed(new_val)


func _on_fever_changed(new_fever: bool):
	if new_fever:
		gradient = fever_gradiant
	else:
		gradient = normal_gradiant
