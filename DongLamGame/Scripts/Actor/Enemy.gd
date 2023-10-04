extends actor
class_name enemy

@onready var time=$Timer
@onready var ani=$AnimationPlayer

var huong=Vector2.ZERO

func _ready():
	target_group = "Player"
	update_bar_HP()


func _physics_process(delta):
	set_velocity_y(delta)
	
	# đặt trạng thái
	if is_death != true:
		if target == null:
			_movement_state(delta)
		else:
			_attack_state()
		
	move_and_slide()

# xử lý hành vi ở trạng thái tấn công
func _attack_state():
	time.wait_time=26
	ani.play("Attack")
	
	# chỉnh hướng quay của thằng quái
	if target.global_position.x - global_position.x > 0:
		$Model.scale.x = 1
	else:
		$Model.scale.x = -1
	
	velocity.x = 0

# xử lý hành vi ở trạng thái di chuyển
func _movement_state(delta):
	# thuật toán chọn hướng đi
	if time.time_left>21:
		huong=0
	if time.time_left<=21 and time.time_left>17:
		huong=-1
	elif time.time_left<=17 and time.time_left>13:
		huong=1
	if time.time_left<=13 and time.time_left>8:
		huong=0
	if time.time_left<=8 and time.time_left>4:
		huong=1
	elif time.time_left<=4:
		huong=-1
	
	velocity.x = huong * speed
	
	if huong == 0:
		ani.play("Idle")
	else:
		ani.play("Run")
	
	if huong > 0:
		$Model.scale.x = 1
	elif huong < 0:
		$Model.scale.x = -1


func _on_plus_one_heath():
	$HeathBar.value += 1
	$PlusHeathSound.play()
