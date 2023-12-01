extends Node

var tween: Tween

func _on_play_pressed():
	GameInit._reset_val()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_how_to_play_pressed():
	tween = create_tween()
	tween.tween_callback(_on_tween_how_to_play_complete)
	tween.tween_property($HowToPlay, "position:x", 668, 0.3)

func _on_close_how_to_play_pressed():
	get_node("HowToPlay/CloseHowToPlay").hide()
	tween = create_tween()
	tween.tween_property($HowToPlay, "position:x", -700, 0.3)

func _on_tween_how_to_play_complete():
	get_node("HowToPlay/CloseHowToPlay").show()

func _on_credits_pressed():
	tween = create_tween()
	tween.tween_callback(_on_tween_credits_complete)
	tween.tween_property($Credits, "position:x", 668, 0.3)
	
func _on_close_credits_pressed():
	get_node("Credits/CloseCredits").hide()
	tween = create_tween()
	tween.tween_property($Credits, "position:x", -700, 0.3)

func _on_tween_credits_complete():
	get_node("Credits/CloseCredits").show()
