extends Node2D

signal finished;
# @export var scalePos: Array[Node2D] = [];
@export var scaleParent: Node2D;

var scaleLeft: int;

# Called when the node enters the scene tree for the first time.
func _ready():
	scaleLeft = scaleParent.get_child_count()
	var scales = get_tree().get_nodes_in_group("scales");
	for scale in scales:
		scale.onDestroy.connect(_remove_scale);
	$AnimatedSprite2D.play("idle")

func _remove_scale():
	scaleLeft -= 1;
	if scaleLeft <= 0:
		hide();


func _on_scale_remover_body_entered(body):
	pass # Replace with function body.
