class_name Player
extends Actor

@onready var main_scene = $".."
@onready var player_start : PlayerStart = $"../PlayerStart"

@export var coin = 0
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -500
@export var is_attacking = false # có thể ngắt khi thay đổi vận tốc
@export var is_rolling = false # không thể ngắt, thay đổi tốc độ
@export var is_using_skill_1 = false # chỉ ngắt khi nhả phím

var gameOverScreen = preload("res://Scene/game_over_screen.tscn")
var anim
var save_system_instance = SaveSystem.new()
var playerData = PlayerData.new()


func _ready():
	load_data()
	anim = $AnimationPlayer
	target_group = "Enemy"
	update_bar_HP()


func _process(delta):
	if !is_death:
		if is_on_floor(): 
			handle_roll()
			handle_attack()
			handle_skill_1()
		handle_animation()


# Để nhân vật có thể di chuyển theo các nút
func _physics_process(delta):
	movement(delta)
	on_key_save_data()


func _on_touching_coin(body):
	if body.is_in_group("Coin") && body != self:
		coin = coin + 1
		$audio_plus_coin.play()
		body.queue_free()
		playerData.coins = coin


func take_damage(damage):
	super.take_damage(damage)
	playerData.health = hp
	
	if hp <= 0:
		save_data()


func shoot_to_mouse():
#	# Điều kiện bắn đạn
#	if Input.is_mouse_button_pressed(1):
#		shoot()
#
#	# xoay turet, hướng nòng súng vào con trỏ chuột
#	$Turet.look_at(get_global_mouse_position())
	pass


func movement(delta):
	set_velocity_y(delta)
	
	if is_death:
		velocity.x = 0
		move_and_slide()
		return
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and !is_rolling:
		velocity.y = JUMP_VELOCITY
	
	# set velocity
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if !is_rolling:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# dùng skill, đánh thì dừng lại
	if is_using_skill_1 || is_attacking:
		velocity.x = 0
		
	# nhích 1 tý thì dừng lại
	if direction != 0 || velocity.y != 0:
		is_attacking = false
	
	# tăng tốc khi roll
	if is_rolling:
		velocity.x = $Model.scale.x * 400
	
	# scale
	if velocity.x > 0:
		$Model.scale.x = 1
	elif velocity.x < 0:
		$Model.scale.x = -1
	
	playerData.global_position = self.global_position
	
	move_and_slide()


func handle_attack():
	if Input.is_action_pressed("Attack"):
		is_attacking = true
		is_rolling = false
		is_using_skill_1 = false
		anim.play("Attack")
		await anim.animation_finished
		is_attacking = false


func handle_roll():
	if Input.is_action_pressed("Roll"):
		is_attacking = false
		is_rolling = true
		is_using_skill_1 = false
		anim.play("Roll")
		await get_tree().create_timer(anim.current_animation_length).timeout
		is_rolling = false


func handle_skill_1():
	if Input.is_action_pressed("Skill_1"):
		if !is_using_skill_1:
			anim.play("Skill_1")
		is_attacking = false
		is_rolling = false
		is_using_skill_1 = true
		def = 2
	
	if Input.is_action_just_released("Skill_1"):
		is_using_skill_1 = false
		def = max_def


func handle_animation():
	if is_rolling || is_using_skill_1 || is_attacking:
		return
	
	if velocity.y < 0:
		$AnimationPlayer.play("Jump")
	elif velocity.y > 0:
		$AnimationPlayer.play("Fall")
	elif velocity.x != 0:
		$AnimationPlayer.play("Run")
	else: 
		$AnimationPlayer.play("Idle")


func handle_player_win():
	var game_over = gameOverScreen.instantiate()
	add_child(game_over)
	game_over.set_title(true)
	get_tree().paused = true


func handle_player_lost():
	var game_over = gameOverScreen.instantiate()
	add_child(game_over)
	game_over.set_title(false)
	get_tree().paused = true
	pass


var is_input_released = false
var check_input_released = false
func on_key_save_data():
	if !Input.is_anything_pressed():
		is_input_released = true
	else:
		is_input_released = false
	
	if is_input_released != check_input_released && is_input_released:
		save_data()


func save_data():
	playerData.current_scene = main_scene.get_name() + ".tscn";
	save_system_instance.save_data_player(playerData)
	check_input_released = is_input_released
	print("saved game")


func load_data():
	playerData = save_system_instance.load_data_player()
	coin = playerData.coins
	hp = playerData.health
	self.global_position = playerData.global_position
	
	if playerData.global_position == Vector2.ZERO:
		self.global_position = player_start.global_position
