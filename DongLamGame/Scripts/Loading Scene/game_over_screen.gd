extends CanvasLayer

@onready var title = $PanelContainer/MarginContainer/Rows/Title

func set_title(win):
	if win:
		title.text = "YOU WIN!"
		title.modulate = Color.GREEN
	else :
		title.text = "YOU LOSE!"
		title.modulate = Color.RED

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scene/menu_scene.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
