extends Node2D

@export var fishes: Array[FishData];
@export var orderLength = 4

var gacha: Gacha;
var order: Array[FishData]

var spawn_pos: Vector2
var center_pos: Vector2
var finish_pos: Vector2

func _ready():
	var viewport_rect = get_viewport_rect().size
	spawn_pos = Vector2(-viewport_rect.x / 2, viewport_rect.y / 2);
	center_pos = viewport_rect / 2;
	finish_pos = Vector2(3 * viewport_rect.x / 2, viewport_rect.y / 2);
	var config = fishes.map(func(e): return e.rate);
	gacha = Gacha.new(config)
	for i in range(orderLength):
		var fish = fishes[gacha.random()]
		order.append(fish)
	next()

func next():
	var current = pop().instantiate()
	add_child(current)
	current.onFinished.connect(onFishFinished)
	current.position = spawn_pos
	var tween = create_tween()
	tween.tween_property(current, "position", center_pos, 1)
	tween.tween_callback(func(): current._setup_scale())
	current.onFinished.connect(onFishFinished)

func pop():
	var entry = order.front()
	order.remove_at(0)
	order.append(fishes[gacha.random()])
	return entry.fish;

func onFishFinished(fish):
	var tween = create_tween()
	tween.tween_property(fish, "position", finish_pos, 1)
	tween.tween_callback(func(): next())
