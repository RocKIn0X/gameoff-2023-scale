extends Node2D

@export var fishes: Array[FishData];
@export var orderLength = 4
@export var board: Node2D;

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
	board.add_child(current)
	board.position = spawn_pos;
	current.onFinished.connect(onFishFinished)
	current.position = Vector2(0,0)
	var tween = create_tween()
	tween.tween_property(board, "position", center_pos, 1)
	tween.tween_callback(func(): current._setup_scale())
	SoundManager._play_sfx(SoundManager.SfxType.Swoosh)

func pop():
	var entry = order.front()
	order.remove_at(0)
	order.append(fishes[gacha.random()])
	return entry.fish;

func onFishFinished(fish):
	var tween = create_tween()
	tween.tween_property(board, "position", finish_pos, 1)
	tween.tween_callback(func():
		fish.queue_free()
		next())
	SoundManager._play_sfx(SoundManager.SfxType.Swoosh)
