extends Node2D

@export var animation: AnimationTree

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.active = true

func _on_spoon_button_up():
	VarManager.set_data(Varkey.B_IS_ENDING, false)
	self.visible = false
	animation.active = false
	self.queue_free()
