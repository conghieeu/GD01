extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play('dissolve')
	await get_tree().create_timer($AnimationPlayer.current_animation_length).timeout
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards('dissolve')
