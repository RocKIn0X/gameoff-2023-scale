extends Node2D

signal onDestroy(scale)

var current;

func spawnScale(scale, size):
	$AnimatedSprite2D.visible = false; 
	if (current):
		current.queue_free()
	current = scale.instantiate()
	current._set_scale(size, size)
	current.onDestroy.connect(onScaleDestroy)
	add_child(current)

func onScaleDestroy(scale):
	onDestroy.emit(scale);
