extends Sprite2D

@export var heath = 10 # Cho phép cài đặt máu boss trên thanh inspector mặc định là 10

func _ready():
	$HeathBar.value = heath # Đặt máu của nút Boss bằng máu nhập vào

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Được gọi khi nhấn nút + máu
func _on_plus_one_heath_pressed():
	$HeathBar.value += 1

# Được gọi khi nhấn nút -1 máu
func _on_minus_one_heath_pressed():
	$HeathBar.value -= 1

# Được gọi khi giá trị(value) của thanh máu có sự thay đổi
func _on_heath_bar_value_changed(value):
	if $HeathBar.value == 0:
		$DeadSound.play() # Nút DeadSound phát nhạc
		print("You died")
