extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	VarManager.on_data_changed.connect(_on_data_changed)


func _on_data_changed(key, new_data, old_data):
	if key == Varkey.F_SCORE_VAL:
		_update_score(new_data)

func _update_score(score):
	$Point.text = str(score)
