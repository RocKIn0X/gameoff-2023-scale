extends Node2D

@export var text: Label;
@export var points_val: int;

func _ready():
	text.text = "+%s" % points_val
	
func _physics_process(delta):
	text.position.y -= delta * 50
	text.self_modulate.a -= delta * 0.5
	if text.self_modulate.a <= 0.0:
		queue_free()
