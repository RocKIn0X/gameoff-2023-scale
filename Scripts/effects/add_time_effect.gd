extends Node2D

@export var time_icon: Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_icon.position.y -= delta * 50
	time_icon.self_modulate.a -= delta * 0.5
	if time_icon.self_modulate.a <= 0.0:
		queue_free()
