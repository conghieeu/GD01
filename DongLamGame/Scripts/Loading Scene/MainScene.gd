extends Node
class_name MainScene

@export var loadingScene: LoadingScene
@onready var player = $Player

func _ready():
	if SaveGame.load_data_player().health > 0 and $CanvasLayer/MenuButton/VBoxContainer/continue != null:
		$CanvasLayer/MenuButton/VBoxContainer/continue.visible = true
	
	set_process_input(true)


func _on_switch_scene_0():
	loadingScene.set_next_scene("res://Scene/scene_0.tscn")


func _on_switch_scene_1():
	loadingScene.set_next_scene("res://Scene/scene_1.tscn")


func _on_btn_credit_pressed():
	get_node("ui_creadit").show()


func _on_new_game_pressed():
	var playerData = PlayerData.new()
	SaveGame.save_data_player(playerData)
	loadingScene.set_next_scene("res://Scene/scene_0.tscn")


func _on_continue_pressed():
	var playerData = PlayerData.new()
	playerData = SaveGame.load_data_player()
	print(playerData.current_scene)
	loadingScene.set_next_scene(playerData.current_scene)


func _on_exit_pressed():
	if(player):
		player.save_data()
	
	get_tree().quit()
