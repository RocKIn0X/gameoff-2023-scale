extends Node2D

@export var score: Label;
@export var restart: Button;
@export var mainmenu: Button;

func _ready():
	VarManager.on_data_changed.connect(_on_var_changed)
	restart.button_up.connect(_restart)
	mainmenu.button_up.connect(_menu)
	hide()


func _on_var_changed(path: String, new_val, old_val):
	if path == Varkey.B_IS_ENDING:
		_on_ending()
	elif path == Varkey.F_SCORE_VAL:
		_on_update_score(new_val)

func _on_ending():
	show()

func _on_update_score(point):
	score.text = str(point)
	
func _restart():
	GameInit._reset_val()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _menu():
	get_tree().change_scene_to_file("res://Scenes/lobby.tscn")
