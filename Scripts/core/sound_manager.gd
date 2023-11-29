extends Node

var bg_music := AudioStreamPlayer.new()

var num_players := 10
var available = []
var queue = []

enum SfxType {
	Click_1,
	Click_2,
	Scaling,
	Sharpening,
	Swoosh,
}

var sfx_list: Array[AudioStream] = [
	preload("res://Sources/Sounds/click_1.mp3"),
	preload("res://Sources/Sounds/click_2.mp3"),
	preload("res://Sources/Sounds/scaling_1.mp3"),
	preload("res://Sources/Sounds/sharpening.mp3"),
	preload("res://Sources/Sounds/swoosh.mp3"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	bg_music.stream = load("res://Sources/Sounds/bgm.mp3")
	bg_music.autoplay = true
	bg_music.bus = "master"
#	bg_music.volume_db = -15
	print("bg volumn: ", str(bg_music.volume_db))
	add_child(bg_music)
	
	for i in num_players:
		var p = AudioStreamPlayer.new()
		p.bus = "Sfx"
		add_child(p)
		available.append(p)
		p.finished.connect(_on_stream_finished.bind(p))

func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)

func _play_sfx(sfx_type):
#	print("play sfx: ", sfx_type)
#	var p = AudioStreamPlayer.new()
#	add_child(p)
#	p.stream = sfx_list[sfx_type]
#	p.play()
#	p.finished.connect(func(): p.queue_free())
	queue.append(sfx_list[sfx_type])
	
func _process(delta):
	# Play a queued sound if any players are available.
	if queue.size() > 0 and available.size() > 0:
		available[0].stream = queue.pop_front()
		available[0].play()
		available.pop_front()
