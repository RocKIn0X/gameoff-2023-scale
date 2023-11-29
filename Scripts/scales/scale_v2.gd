extends RigidBody2D

class_name Scale

signal onDestroy(scale)

enum Type { Normal, AddTime }

@export var type: Type
@export var health: int = 2;
@export var point: int = 1; 
@export var time_add: int = 15;
@export var sharpness_cost: int = 1;
@export var hit_blink_ms: int = 500;
@export var hit_color: Color
@export var bounce_force: float = 50000.0
@export var bounce_ms: int = 500;
@export var trail_prefab: PackedScene;
@export var point_prefab: PackedScene;

var is_fx := false
var hit_time: float
var trail : Node
var point_fx : Node
var time_prefab := preload("res://Scenes/Effects/add_time_effect.tscn")

func _ready():
	$AnimatedSprite2D.play("idle")

func get_point(): return point;
func get_type(): return type;
func get_time_add(): return time_add;

func hit():
	if is_fx:
		return
	var is_paused = VarManager.get_data(Varkey.B_IS_PAUSED);
	var is_ending = VarManager.get_data(Varkey.B_IS_ENDING);
	if is_paused or is_ending: return
	var current_sharpness = VarManager.get_data(Varkey.F_SHARPNESS_VAL);
	if current_sharpness <= 0: return
	health -= GameCalculation.get_attack_power()
	hit_time = Time.get_unix_time_from_system()
	if not VarManager.get_data(Varkey.B_IS_FEVER):
		var sharpness = max(
			current_sharpness
			- (GameCalculation.get_sharpness_loss_rate() * sharpness_cost)
		, 0.0)
		VarManager.set_data(Varkey.F_SHARPNESS_VAL, sharpness)
	if health <= 0:
		_to_fx()
	SoundManager._play_sfx(SoundManager.SfxType.Scaling)

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
	trail.position = Vector2.ZERO
	trail.global_position = Vector2.ZERO
	_point_fx()
	$"..".add_child(trail)
	$"/root".add_child(point_fx)
	reparent(get_tree().root) # Override masking

func _point_fx():
	match (type):
		Type.Normal:
			point_fx = point_prefab.instantiate()
			point_fx.points_val = get_point()
		Type.AddTime:
			point_fx = time_prefab.instantiate()
	
	point_fx.position = Vector2.ZERO
	point_fx.global_position = global_position

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
