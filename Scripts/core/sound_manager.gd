extends Node

var bg_music := AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	bg_music.stream = load("res://Sources/Sounds/bgm.mp3")
	bg_music.autoplay = true
	add_child(bg_music)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
