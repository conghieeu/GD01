extends actor
class_name Player

# Nhận trọng lực từ cài đặt dự án để được đồng bộ hóa với các nút RigidBody.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var SPEED = 300.0
@onready var JUMP_VELOCITY = -500

func _ready():
	update_bar_HP()
	target_group = "Enemy"

func _process(delta):
	attack()

# Để nhân vật có thể di chuyển theo các nút
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if velocity.y > 0:
		$AnimationPlayer.play("Jump")
		print("Jump")
		
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		$AnimationPlayer.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimationPlayer.play("Idle")

	if velocity.x > 0:
		$Model.scale.x = 1
	elif velocity.x < 0:
		$Model.scale.x = -1

	move_and_slide()

func _on_area_2d_body_entered(body):
	send_damage(body)

func attack():
	if Input.is_mouse_button_pressed(1):
		$Model/Area2D/Hit_Box.disabled = false
		#$AnimatedSprite.animation = "Attack"
	else:
		$Model/Area2D/Hit_Box.disabled = true


