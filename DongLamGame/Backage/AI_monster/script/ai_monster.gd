extends CharacterBody2D

@onready var time=$Timer
@onready var ani=$AnimationPlayer
@export var heath = 10 # Cho phép cài đặt máu boss trên thanh inspector mặc định là 10

var huong=Vector2.ZERO
var vi_tri
var gravity=200
var speed=100

func _ready():
	$HeathBar.value = heath # Đặt máu của nút Boss bằng máu nhập vào

func _process(delta):
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
	
	if huong.x > 0:
		$Model.scale.x = 1
	elif huong.x < 0:
		$Model.scale.x = -1
	
	move_and_slide()

# nhân vật khác sẽ gọi vào đây
func take_damage():
	_on_minus_one_heath_pressed()

# Được gọi khi nhấn nút + máu
func _on_plus_one_heath_pressed():
	$HeathBar.value += 1
	$PlusHeathSound.play()

# Được gọi khi nhấn nút -1 máu
func _on_minus_one_heath_pressed():
	$HeathBar.value -= 1
	$MinusHeathSound.play()

# Được gọi khi giá trị(value) của thanh máu có sự thay đổi
func _on_heath_bar_value_changed(value):
	if $HeathBar.value == 0:
		$DeadSound.play() # Nút DeadSound phát nhạc
		print("Boss died")
	
	
	
	
	
	
	







