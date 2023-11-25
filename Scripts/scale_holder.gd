extends Node2D

var current;

func spawnScale(scale, size):
	$AnimatedSprite2D.visible = false; 
	if (current):
		current.queue_free()
	current = scale.instantiate()
	current._set_scale(size, size)
	add_child(current)
