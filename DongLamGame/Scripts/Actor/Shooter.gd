extends Node2D

@export var actor: Actor
const bulletPath = preload("res://Prefabs/Arrow_1.tscn")

func shoot():
	# spawn đạn
	var bullet = bulletPath.instantiate()
	
	# thiết lập viên đạn
	bullet.global_position = $Turet/ShootPos.global_position
	bullet.direction = $Turet/ShootPos.global_position - $Turet.global_position
	bullet.target_group = actor.target_group
	
	get_tree().get_root().add_child(bullet)
