extends CharacterBody2D
class_name Actor

@onready var target_group : String
@export var max_hp = 100
@export var hp = 100
@export var max_mp = 10
@export var mp = 10
@export var max_def = 0
@export var def = 0
@export var max_speed = 100
@export var speed = 50
@export var physicDamage = 1
@export var count_item_drop = 3
@export var item_drop = preload("res://Prefabs/coin.tscn")

# Nhận trọng lực từ cài đặt dự án để được đồng bộ hóa với các nút RigidBody.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_death = false
var target # nếu có mục tiêu thì enemy ở trạng thái tấn công


# trừ damage
func take_damage(damage):
	# hết máu rồi thì ngưng nhận damage
	if hp <= 0:
		return
	
	var damage_in = damage - def
	if damage_in < 0:
		damage_in = 0
	hp -= damage_in 
	
	print(hp)
	
	update_bar_HP()
	$HeathBar.play_minus_heath_sound()
	on_death()
	
# Lấy đối tượng kẻ địch
func _on_area_2d_body_entered(body):
	if body.is_in_group(target_group) && body != self:
		target = body
func _on_area_2d_body_exited(body):
	if body == target:
		target = null

# nếu đối tượng va chạm có group hit thì gọi take_damge của nó
func send_damage():
	if target != null:
		if target.is_in_group(target_group) && target != self:
			print(self.name, " hit: ", target.name)
			target.take_damage(physicDamage)

# được gọi cùng với take_damage
func on_death():
	if hp <= 0:
		$HeathBar.play_dead_sound()
		$AnimationPlayer.play("Death")
		is_death = true
		drop_item()

# tỷ lệ phần trăm máu còn lại
func remaining_hp() -> float:
	return hp * 1.0 / max_hp
	
func remaining_mp() -> float:
	return mp * 1.0 / max_mp

func set_velocity_y(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

# rớt vật phẩm
func drop_item():
	print(self.name + ": Drop item")
	var item = item_drop.instantiate()
	get_tree().root.add_child(item)
	
	# rớt với số lượng
	for n in count_item_drop:
		item.global_position = global_position

func update_bar_HP():
	if hp <= 0:
		hp = 0
	print(remaining_hp())
	$HeathBar.value = remaining_hp()
