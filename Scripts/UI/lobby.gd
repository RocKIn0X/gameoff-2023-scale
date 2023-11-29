extends Node

func _on_play_pressed():
	GameInit._reset_val()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_pressed():
	get_tree().quit()
