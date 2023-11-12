extends Area2D

signal onDestroy

@export var health = 2;

func hit():
	health -= 1
	if (health <= 0):
		onDestroy.emit()
		$CollisionShape2D.disabled = false;
		queue_free()


func _on_mouse_entered():
	hit();
