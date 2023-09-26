extends Node

signal safe_to_load

@onready var animPlayer = $AnimationPlayer

var nextScene = ""
var progress = []
var scene_load_status = 0

func _ready():
#	nextScene = "res://Scene/scene_1.tscn"
#	ResourceLoader.load_threaded_request(nextScene)
	pass

#func _process(delta):
#	load_status()
#
#func load_status():
#	await safe_to_load
#	self.queue_free()
#
#	scene_load_status = ResourceLoader.load_threaded_get_status(nextScene, progress)
#	$Control/ProgressBar.value = progress[0]*100
#
#	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
#		var newScene = ResourceLoader.load_threaded_get(nextScene)
#		get_tree().change_scene_to_packed(newScene)
#
#func set_next_scene(path):
#	nextScene = path
#	ResourceLoader.load_threaded_request(nextScene)
#	pass

# chạy animation tạo hiện ứng mở screen mới
func fade_out_loading_screen():
#	animPlayer.play('dissolve')
#	await get_tree().create_timer(animPlayer.current_animation_length).timeout
#	await animPlayer.animation_finished
	animPlayer.play_backwards('dissolve')

