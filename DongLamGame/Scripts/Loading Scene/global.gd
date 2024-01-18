extends Node
@onready var ui_credit_scene = preload("res://Scene/ui_credit.tscn")

var loading_screen = preload("res://Scene/loading_screen.tscn")

func load_scene(current_scene, next_scene):
	# Tạo mới loading screen instance
	var loading_screen_instance = loading_screen.instantiate()
	
	get_tree().get_root().call_deferred("add_child", loading_screen_instance)

	var load_path : String

	# đợi animation chuyển cảnh vào chạy xong
	await loading_screen_instance.safe_to_load
	current_scene.queue_free()
