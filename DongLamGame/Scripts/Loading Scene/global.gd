extends Node
# đây là script global

@onready var ui_credit_scene = preload("res://Scene/ui_credit.tscn")

var loading_screen = preload("res://Scene/loading_screen.tscn")

const GAME_SCENES = {
	"ui_credit": "res://Scene/ui_credit.tscn",
	"scene_0": "res://Scene/scene_0.tscn",
	"scene_1": "res://Scene/scene_1.tscn",
	"menu_scene" : "res://Scene/menu_scene.tscn"
}

func load_scene(current_scene, next_scene):
	# Tạo mới loading screen instance
	var loading_screen_instance = loading_screen.instantiate()
	get_tree().get_root().call_deferred("add_child", loading_screen_instance)

	var load_path : String
	load_path = get_load_path(next_scene)
	
	# báo scene cần chuyển 
#	loading_screen_instance.set_next_scene(load_path)

	# đợi animation chuyển cảnh vào chạy xong
	await loading_screen_instance.safe_to_load
	current_scene.queue_free()

	# trạng thái load
	while true:
		var load_progress = []
		var load_status = ResourceLoader.load_threaded_get_status(load_path, load_progress)

#		loading_screen_instance.get_node("Control/ProgressBar").value = load_progress[0]*100
	
		if load_status == ResourceLoader.THREAD_LOAD_LOADED:
			var newScene = ResourceLoader.load_threaded_get(load_path)
			get_tree().change_scene_to_packed(newScene)
			loading_screen_instance.fade_out_loading_screen()
			return
			
#		match load_status:
#			0:
#				print("error: cannot load, resource is invalid")
#				return
#			1:
##				loading_screen_instance.get_node("Control/ProgressBar").value = load_progress[0]
#				pass
#			2:
#				print("error: Loading failed!")
#				return
#			3:
#				var next_scene_instance = ResourceLoader.load_threaded_get(load_path).instantiate()
#				get_tree().get_root().call_deferred("add_child", next_scene_instance)
#
#				loading_screen_instance.fade_out_loading_screen()
#				return

# Finds the path to the scene file (needs to fetch from GAME_SCENES if applicable
func get_load_path(name_scene) -> String:
	var load_path : String
	if GAME_SCENES.has(name_scene):
		load_path = GAME_SCENES[name_scene]
	else :
		load_path = name_scene

	var loader_next_scene
	if ResourceLoader.exists(load_path):
		loader_next_scene = ResourceLoader.load_threaded_request(load_path)

	if loader_next_scene == null:
		print("error: Attempting to load non-existent file!")

	return load_path

func instance_credit_scene():
	var credit = ui_credit_scene.instantiate()
	get_tree().root.add_child(credit)
