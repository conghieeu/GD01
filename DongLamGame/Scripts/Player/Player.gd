extends CharacterBody2D
class_name Player

# Nhận trọng lực từ cài đặt dự án để được đồng bộ hóa với các nút RigidBody.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _process(delta):
	if Input.is_mouse_button_pressed(1):
		$Model/Area2D/CollisionShape2D.disabled = false
		#$AnimatedSprite.animation = "Attack"
	else:
		$Model/Area2D/CollisionShape2D.disabled = true

# Để nhân vật có thể di chuyển theo các nút
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x > 0:
		$Model.scale.x = 1
	elif velocity.x < 0:
		$Model.scale.x = -1

	move_and_slide()

func _on_area_2d_body_entered(body):
	# nếu đối tượng va chạm có group hit thì gọi take_damge của nó
	if body.is_in_group("Hit") && body != self:
		print("Player hit: ", body.name)
		body.take_damage()

