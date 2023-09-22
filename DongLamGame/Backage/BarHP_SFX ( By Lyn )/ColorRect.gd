extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Được gọi khi nhấn nút + máu
func _on_plus_one_heath_pressed():
	$PlusOneHeath/PlusHeathSound.play() # nút PlusHeathSound chơi nhạc (phần SFX)
	pass # Replace with function body.

# Được gọi khi nhấn nút -1 máu
func _on_minus_one_heath_pressed():
	$MinusOneHeath/MinusHeathSound.play() # nút MinusHeathSound chơi nhạc (phần SFX)
	pass # Replace with function body.
