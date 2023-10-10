extends Node

# tạo file save ở máy người dùng
# const SAVE_PATH = "user://save_file.save"

# tạo file save ở dự án này
const SAVE_PATH = "res://save_file.save"

# save dữ liệu
func save(value: String):
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(value)

# load dữ liệu từ path Save Path
func load_data(value: String) -> String:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		value = str(file.get_var(int(value)))
	else:
		print("no data saved...")
		return "null"
	
	return value
