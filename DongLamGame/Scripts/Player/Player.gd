extends actor
class_name Player

var gameOverScreen = preload("res://Scene/game_over_screen.tscn")


@export var coin = 0
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -500
@export var is_attacking = false

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

func _on_touching_coin(body):
	if body.is_in_group("Coin") && body != self:
		coin = coin + 1
		$audio_plus_coin.play()
		body.queue_free()

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
	set_velocity_y(delta)
	
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

func handle_player_win():
	var game_over = gameOverScreen.instantiate()
	add_child(game_over)
	game_over.set_title(true)
	get_tree().paused = true
	pass

func handle_player_lost():
	var game_over = gameOverScreen.instantiate()
	add_child(game_over)
	game_over.set_title(false)
	get_tree().paused = true
	pass
