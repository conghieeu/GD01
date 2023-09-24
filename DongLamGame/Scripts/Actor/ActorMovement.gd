extends Node2D

@export var character_body : CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Để nhân vật có thể di chuyển theo các nút
func _physics_process(delta):
	# Add the gravity.
	
	if not character_body.is_on_floor():
		character_body.velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and character_body.is_on_floor():
		character_body.velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		character_body.velocity.x = direction * SPEED
	else:
		character_body.velocity.x = move_toward(character_body.velocity.x, 0, SPEED)

	character_body.move_and_slide()

