extends actor
class_name Player

var gameOverScreen = preload("res://Scene/game_over_screen.tscn")

@export var coin = 0
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -500
@export var is_attacking = false
@export var is_rolling = false

var anim

func _ready():
	anim = $AnimationPlayer
	target_group = "Enemy"
	update_bar_HP()

func _process(delta):
	if !is_death: 
		handle_roll()
		handle_attack()
		handle_animation()

# Để nhân vật có thể di chuyển theo các nút
func _physics_process(delta):
	if !is_death:
		movement(delta)

func _on_touching_coin(body):
	if body.is_in_group("Coin") && body != self:
		coin = coin + 1
		$audio_plus_coin.play()
		body.queue_free()


func handle_attack():
	if Input.is_mouse_button_pressed(1) && !is_rolling:
		is_attacking = true
		$AnimationPlayer.play("Attack")
		await $AnimationPlayer.animation_finished
		is_attacking = false

func handle_roll():
	if Input.is_action_pressed("roll") && !is_attacking && is_on_floor():
		is_rolling = true
		$AnimationPlayer.play("Roll")
		await get_tree().create_timer(anim.current_animation_length).timeout
		is_rolling = false

func handle_animation():
	if is_attacking || is_rolling:
		return
	
	if velocity.y < 0:
		$AnimationPlayer.play("Jump")
	elif velocity.y > 0:
		$AnimationPlayer.play("Fall")
	elif velocity.x != 0:
		$AnimationPlayer.play("Run")
	else: 
		$AnimationPlayer.play("Idle")

func movement(delta):
	set_velocity_y(delta)
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# set direction
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0 || velocity.y != 0:
		is_attacking = false
	
	if is_rolling:
		velocity.x = $Model.scale.x * 400
	else :
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# scale
	if velocity.x > 0:
		$Model.scale.x = 1
	elif velocity.x < 0:
		$Model.scale.x = -1
	
	move_and_slide()

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

