extends Node2D

signal finished;

@export var scaleParent: Node2D;
@export var fishScales: Array[ScaleData];

var scaleLeft: int;
var gacha: Gacha;

# Called when the node enters the scene tree for the first time.
func _ready():
	var config = fishScales.map(func(e): return e.rate);
	gacha = Gacha.new(config)

	var scales = get_tree().get_nodes_in_group("scales");
	scaleLeft = scales.size()
	for i in scales.size():
		scales[i].spawnScale(getRandomScale(), scale.x)
	for scale in scales:
		scale.onDestroy.connect(_remove_scale);
	$AnimatedSprite2D.play("idle")

func _remove_scale(scale):
	scaleLeft -= 1;
	if scaleLeft <= 0:
		hide();


func _on_scale_remover_body_entered(body):
	pass # Replace with function body.

func getRandomScale():
	var index = gacha.random()
	return fishScales[index].scale;
