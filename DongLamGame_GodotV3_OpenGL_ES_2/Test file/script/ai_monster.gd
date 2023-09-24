extends CharacterBody2D

@onready var time=$Timer
@onready var ani=$AnimationPlayer

var huong=Vector2.ZERO
var vi_tri
var gravity=200
var speed=100

func _process(delta):
	time -= delta.time
	
	if time.time_left>21:
		huong=Vector2()
		ani.play("idel_AI")
	if time.time_left<=21 and time.time_left>17:
		huong=Vector2(-1,0)	
		ani.play("run_AI")
	elif time.time_left<=17 and time.time_left>13:
		huong=Vector2(1,0)
		ani.play("run_AI")
	if time.time_left<=13 and time.time_left>8:
		huong=Vector2()
		ani.play("idel_AI")
	if time.time_left<=8 and time.time_left>4:
		huong=Vector2(1,0)
		ani.play("run_AI")
	elif time.time_left<=4:
		huong=Vector2(-1,0)
		ani.play("run_AI")
	
func _physics_process(delta):
	velocity=huong*speed
	move_and_slide()


	
	
	
	
	
	
	
	
	







