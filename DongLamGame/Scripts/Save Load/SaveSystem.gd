extends Node

# tạo file save ở máy người dùng
# const SAVE_PATH = "user://save_file.save"

# tạo file save ở dự án này
const SAVE_PATH = "res://save_file.save"

var coin = 0

# save dữ liệu
func save():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(coin)

# load dữ liệu từ path Save Path
func load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		coin = file.get_var(coin)
	else:
		print("no data saved...")
		coin = 0
