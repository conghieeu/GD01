extends ColorRect
# chuyển cảnh cơ bản


# cách 1 đi kèm có kích hoạt hiện ứng chuyển cảnh
func onSwitchScene():
	SceneTransition.change_scene('res://Scene/scene_0.tscn')

# Cách 2 không có hiện ứng chuyển cảnh
var pscene = load("res://Scene/scene_1.tscn")
func onSwitchScene_1():
	get_tree().change_scene_to_packed(pscene)
