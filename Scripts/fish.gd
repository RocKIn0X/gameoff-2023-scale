extends Node2D

class_name Fish

signal onFinished(fish);

@export var scaleParent: Node2D;
@export var fishScales: Array[ScaleData];

var scaleLeft: int;
var gacha: Gacha;

# Called when the node enters the scene tree for the first time.
func _ready():
	var config = fishScales.map(func(e): return e.rate);
	gacha = Gacha.new(config)

#	_setup_scale()

func _setup_scale():
	var scales = scaleParent.get_children()
	scaleLeft = scales.size()
	for i in scales.size():
		scales[i].spawnScale(getRandomScale(), scale.x)
		scales[i].onDestroy.connect(_remove_scale);
	$AnimatedSprite2D.play("idle")

func _remove_scale(scale):
	scaleLeft -= 1;
	var cur = VarManager.get_data(Varkey.F_SCORE_VAL);
	VarManager.set_data(Varkey.F_SCORE_VAL, cur + scale.get_point());
	if scaleLeft <= 0:
		var count = $AnimatedSprite2D.sprite_frames.get_frame_count("done")
		$AnimatedSprite2D.play("done")
		onFinished.emit(self);

func getRandomScale():
	var index = gacha.random()
	return fishScales[index].scale;

func test():
	print("Test fish")
