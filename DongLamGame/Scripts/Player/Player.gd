extends actor
class_name Player

# Nhận trọng lực từ cài đặt dự án để được đồng bộ hóa với các nút RigidBody.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var SPEED = 300.0
@onready var JUMP_VELOCITY = -500
@onready var is_attacking = false

func _ready():
	update_bar_HP()
	target_group = "Enemy"

func _process(delta):
	if is_death:
		return

	animation_handle()
	attack()

# Để nhân vật có thể di chuyển theo các nút
func _physics_process(delta):
	if is_death:
		return

	movement(delta)
	

func on_death():
	super.on_death()
	if is_death:
		print("Game Over")

func animation_handle():
	
	if is_attacking == false:
		if velocity.y < 0:
			$AnimationPlayer.play("Jump")
		elif velocity.y > 0:
			$AnimationPlayer.play("Fall")
		elif velocity.x != 0:
			$AnimationPlayer.play("Run")
		else: 
			$AnimationPlayer.play("Idle")
	else :
		$AnimationPlayer.play("Attack")

func movement(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# set direction
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction != 0 || velocity.y != 0:
		is_attacking = false
	
	# scale
	if velocity.x > 0:
		$Model.scale.x = 1
	elif velocity.x < 0:
		$Model.scale.x = -1
		
	move_and_slide()

func attack():
	if Input.is_mouse_button_pressed(1):
		is_attacking = true
		await $AnimationPlayer.animation_finished
		is_attacking = false


