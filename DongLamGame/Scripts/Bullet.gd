extends RigidBody2D

var target_group
var direction = Vector2(1, 0)
var speed = 1000
var damage = 1
var target


func set_bullet(speed, damage, direction, target_group):
	self.speed = speed
	self.damage += damage
	self.direction = direction
	self.target_group = target_group


func _ready():
	set_gravity_scale(0)


func _physics_process(delta):
	if direction.x < 0:
		$Model.scale.x = -1
	else:
		$Model.scale.x = 1
	
	if target == null:
		move_and_collide(direction.normalized() * delta * speed)
	else: # is hit target
		move_and_collide(Vector2.ZERO)

# khi đạn chạm vào kẻ địch
func _on_area_2d_body_entered(body):
	if body.is_in_group(target_group) and body != self:
		target = body
		$AnimationPlayer.play("Hit")
		target.take_damage(damage)
		await $AnimationPlayer.animation_finished
		self.queue_free()
