extends CharacterBody2D
class_name actor

@onready var target_group : String
@export var max_hp = 10
@export var hp = 10
@export var max_mp = 10
@export var mp = 10
@export var physicDamage = 1

# trừ damage
func take_damage(damage):
	hp -= damage
	update_bar_HP()
	$HeathBar.play_minus_heath_sound()
	on_death()
	
# nếu đối tượng va chạm có group hit thì gọi take_damge của nó
func send_damage(target):
	if target.is_in_group(target_group) && target != self:
		print("Player hit: ", target.name)
		target.take_damage(physicDamage)

func on_death():
	if hp <= 0:
		$HeathBar.play_dead_sound()

# tỷ lệ phần trăm máu còn lại
func remaining_hp() -> float:
	return hp * 1.0 / max_hp
	
func remaining_mp() -> float:
	return mp * 1.0 / max_mp

func update_bar_HP():
	if hp <= 0:
		hp = 0

	$HeathBar.value = remaining_hp()
