extends RigidBody2D

@export var heath = 10 # Cho phép cài đặt máu boss trên thanh inspector mặc định là 10

func _ready():
	$HeathBar.value = heath # Đặt máu của nút Boss bằng máu nhập vào

# nhân vật khác sẽ gọi vào đây
func take_damage():
	_on_minus_one_heath_pressed()

# Được gọi khi nhấn nút + máu
func _on_plus_one_heath_pressed():
	$HeathBar.value += 1
	$PlusHeathSound.play()

# Được gọi khi nhấn nút -1 máu
func _on_minus_one_heath_pressed():
	$HeathBar.value -= 1
	$MinusHeathSound.play()

# Được gọi khi giá trị(value) của thanh máu có sự thay đổi
func _on_heath_bar_value_changed(value):
	if $HeathBar.value == 0:
		$DeadSound.play() # Nút DeadSound phát nhạc
		print("Boss died")
