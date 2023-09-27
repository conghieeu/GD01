extends CharacterBody2D
class_name actor

@onready var target_group : String
@export var max_hp = 10
@export var hp = 10
@export var max_mp = 10
@export var mp = 10
@export var physicDamage = 1

var is_death = false
var target # nếu có mục tiêu thì enemy ở trạng thái tấn công

# trừ damage
func take_damage(damage):
	# hết máu rồi thì ngưng nhận damage
	if hp <= 0:
		return
	
	hp -= damage
	update_bar_HP()
	$HeathBar.play_minus_heath_sound()
	on_death()
	
# Lấy đối tượng kẻ địch
func _on_area_2d_body_entered(body):
	if body.is_in_group(target_group) && body != self:
		target = body
func _on_area_2d_body_exited(body):
	if body.is_in_group(target_group) && body != self:
		target = null

# nếu đối tượng va chạm có group hit thì gọi take_damge của nó
func send_damage():
	if target != null:
		if target.is_in_group(target_group) && target != self:
			print("Player hit: ", target.name)
			target.take_damage(physicDamage)

func on_death():
	if hp <= 0:
		$HeathBar.play_dead_sound()
		$AnimationPlayer.play("Death")
		is_death = true

# tỷ lệ phần trăm máu còn lại
func remaining_hp() -> float:
	return hp * 1.0 / max_hp
	
func remaining_mp() -> float:
	return mp * 1.0 / max_mp

func update_bar_HP():
	if hp <= 0:
		hp = 0

	$HeathBar.value = remaining_hp()
