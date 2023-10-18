extends Node
class_name MainScene


func _ready():
	if SaveGame.load_data_player().health <= 0:
		$CanvasLayer/MenuButton/VBoxContainer/continue.visible = false


func _on_switch_scene_1():
	Global.load_scene(self, "res://Scene/scene_1.tscn")


func _on_switch_scene_0():
	Global.load_scene(self, "res://Scene/scene_0.tscn")


func _on_btn_credit_pressed():
	Global.instance_credit_scene()


func _on_new_game_pressed():
	var playerData = PlayerData.new()
	SaveGame.save_data_player(playerData)
	Global.load_scene(self, "res://Scene/scene_0.tscn")


func _on_continue_pressed():
	var playerData = PlayerData.new()
	playerData = SaveGame.load_data_player()
	Global.load_scene(self, "res://Scene/" + playerData.current_scene)


func _on_exit_pressed():
	get_tree().quit()
