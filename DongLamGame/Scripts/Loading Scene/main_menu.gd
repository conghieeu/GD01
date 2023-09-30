extends Node

func _on_switch_scene_0():
	Global.load_scene(self, "res://Scene/scene_0.tscn")
	
func _on_switch_scene_1():
	Global.load_scene(self, "res://Scene/scene_1.tscn")

func _on_btn_credit_pressed():
	Global.instance_credit_scene()
