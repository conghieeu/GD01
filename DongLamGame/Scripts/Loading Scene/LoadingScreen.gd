extends CanvasLayer
class_name LoadingScene

signal safe_to_load

@onready var animPlayer = $AnimationPlayer


func _ready():
	if(get_tree().get_current_scene().get_name() == "menu_scene"):
		self.hide()
	else:
		self.show()
		animPlayer.play('solve')


# chạy animation tạo hiện ứng mở screen mới
func set_next_scene(nextScene):
	self.show()
	animPlayer.play('dissolve')
	
	await safe_to_load
	get_tree().change_scene_to_file(nextScene)
	



