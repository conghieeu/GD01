extends ColorRect

# tạo file save ở máy người dùng
# const SAVE_PATH = "user://save_file.save"

# tạo file save ở dự án này
const SAVE_PATH = "res://save_file.save"

var a = 0
var b = 0
var c = 0

var texta
var textb
var textc

func _ready():
	texta = $a
	textb = $b
	textc = $c
	load_data()
	
func _process(delta):
	texta.text = str(a);
	textb.text = str(b);
	textc.text = str(c);

func _on_minus_a_pressed():
	a -= 1
func _on_plus_a_pressed():
	a += 1
func _on_minus_b_pressed():
	b -= 1
func _on_plus_b_pressed():
	b += 1
func _on_minus_c_pressed():
	c -= 1
func _on_plus_c_pressed():
	c += 1

# được gọi khi nhấn nút save
func _on_save_button_pressed(): 
	save()

# được gọi khi nhấn nút load
func  _on_load_button_pressed():
	load_data()
	
# save dữ liệu
func save():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(a)
	file.store_var(b)
	file.store_var(c)

# load dữ liệu từ path Save Path
func load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		a = file.get_var(a)
		b = file.get_var(b)
		c = file.get_var(c)
	else:
		print("no data saved...")
		a = 0
		b = 0
		c = 0
