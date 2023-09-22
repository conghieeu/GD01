extends Node2D

@export var camera2D : Camera2D
@export var player : Player

@warning_ignore("unused_parameter")
func _process(delta):
	# Di chuyển camera theo tốc độ đã tính toán
	camera2D.position = Vector2(player.position.x, player.position.y - 200)
