extends actor
class_name npc

@onready var interaction_area = $interaction_area
@onready var sprite = $AnimatedSprite2D
@onready var speech_sound = preload("res://Audio/sound_effect_coin_1.mp3")
@onready var MarkerDialogBox = $Model/MarkerDialogBox

var overlapping_body

func _physics_process(delta):
	set_velocity_y(delta)
	move_and_slide()

const lines: Array[String] = [
	"Này, nhìn bạn trông có vẻ rất là mạnh",
	"Muốn đánh nhau à?",
	"Đợi đã...",
	"Tôi không nên phí sức trước một trận đấu quan trọng...",
	"Thì, tôi sẽ gặp bạn ở đấu trường"
]

# nhận sự kiện vào từ phím
func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		if overlapping_body != null:
			InteractionLabel.hide_label()
			DialogManager.start_dialog(MarkerDialogBox.global_position, lines, speech_sound)
			# flip, look to player
			if overlapping_body.global_position.x - global_position.x > 0:
				$Model.scale.x = 1 
			else:
				$Model.scale.x = -1

func _on_interaction_area_body_entered(body):
	if body.is_in_group("Player") && body != self:
		if DialogManager.is_dialog_active == false:
			overlapping_body = body
			InteractionLabel.show_label(global_position, "talk")

func _on_interaction_area_body_exited(body):
	if body.is_in_group("Player") && body != self:
		overlapping_body = null
		InteractionLabel.hide_label()

