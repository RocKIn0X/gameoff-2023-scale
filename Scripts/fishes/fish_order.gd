extends Node2D

@export var fishes: Array[FishData];
@export var orderLength = 4
@export var board: Node2D;

var gacha: Gacha;
var order: Array[FishData]

var spawn_pos: Vector2
var center_pos: Vector2
var finish_pos: Vector2
var tween: Tween

func _ready():
	VarManager.on_data_changed.connect(_on_var_changed)
	var viewport_rect = get_viewport_rect().size
	spawn_pos = Vector2(-viewport_rect.x / 2, viewport_rect.y / 2);
	center_pos = viewport_rect / 2;
	finish_pos = Vector2(3 * viewport_rect.x / 2, viewport_rect.y / 2);
	var config = fishes.map(func(e): return e.rate);
	gacha = Gacha.new(config)
	for i in range(orderLength):
		var fish = fishes[gacha.random()]
		order.append(fish)

func _on_var_changed(path: String, new_val, old_val):
	if path == Varkey.B_IS_PAUSED:
		_pause(new_val)
	if path == Varkey.B_IS_ENDING:
		_start(new_val)

func _start(is_ending):
	if !is_ending: next()
	else: if tween: tween.pause()

func _pause(is_paused):
	if !tween: return
	if is_paused: tween.pause()
	else: tween.play()

func next():
	var current = pop().instantiate()
	board.add_child(current)
	board.position = spawn_pos;
	current.onFinished.connect(onFishFinished)
	current.position = Vector2(0,0)
	tween = create_tween()
	tween.tween_property(board, "position", center_pos, 1)
	tween.tween_callback(func():
		current._setup_scale()
		tween = null)
	SoundManager._play_sfx(SoundManager.SfxType.Swoosh)

func pop():
	var entry = order.front()
	order.remove_at(0)
	order.append(fishes[gacha.random()])
	return entry.fish;

func onFishFinished(fish):
	tween = create_tween()
	tween.tween_property(board, "position", finish_pos, 1)
	tween.tween_callback(func():
		fish.queue_free()
		tween = null
		next())
	SoundManager._play_sfx(SoundManager.SfxType.Swoosh)
