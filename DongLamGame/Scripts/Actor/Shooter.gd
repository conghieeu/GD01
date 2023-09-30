extends Node2D

const bulletPath = preload("res://Prefabs/bullet.tscn")

func _process(delta):
	# Điều kiện bắn đạn
	if Input.is_mouse_button_pressed(1):
		shoot()

	# xoay turet, hướng nòng súng vào con trỏ chuột
	$Turet.look_at(get_global_mouse_position())

func shoot():
	# instance đạn
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)

	# thiết lập velocity viên đạn
	bullet.position = $Turet/ShootPos.global_position
	bullet.direction = get_global_mouse_position() - bullet.position
