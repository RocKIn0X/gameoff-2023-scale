extends RigidBody2D

signal onDestroy(scale)

@export var health: int = 2;
@export var hit_blink_ms: int = 500;
@export var hit_color: Color
@export var bounce_force: float = 50000.0
@export var bounce_ms: int = 500;
@export var trail_prefab: PackedScene

var is_fx := false
var hit_time: float
var trail : Node

func _ready():
	$AnimatedSprite2D.play("idle")

func hit():
	if is_fx:
		return
	health -= 1
	hit_time = Time.get_unix_time_from_system()
	if health <= 0:
		_to_fx()

func _set_scale(x, y):
	$CollisionShape2D.scale = Vector2(x, y)
	$AnimatedSprite2D.scale = Vector2(x, y)

func _to_fx():
	is_fx = true
	hit_time = Time.get_unix_time_from_system()
	gravity_scale = 10.0
	var direction = randf() - 0.5
	var force = (randf() + 0.5) * bounce_force
	var rand_force = Vector2(direction, -1.0 + abs(direction)) * force
	apply_force(rand_force)
	trail = trail_prefab.instantiate()
	trail.tracked_object = self
	trail.position = Vector2(0, 0)
	trail.global_position = Vector2(0, 0)
	$"..".add_child(trail)
	reparent(get_tree().root) # Override masking


func _on_fx_done():
	onDestroy.emit(self)
	if trail != null:
		trail.queue_free()
	$CollisionShape2D.disabled = false;
	queue_free()


func _on_mouse_entered():
	hit();


func _physics_process(_delta):
	var current_time := Time.get_unix_time_from_system()
	if current_time < hit_time + (hit_blink_ms as float) / 1000:
		modulate = hit_color
	else:
		modulate = Color.WHITE
	if is_fx and current_time > hit_time + (bounce_ms as float) / 1000:
		_on_fx_done()
