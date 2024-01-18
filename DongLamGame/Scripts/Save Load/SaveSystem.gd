extends Node
class_name SaveSystem

# Đường dẫn thư mục lưu trữ file save
const SAVE_DIR = "res://saves/"
# Tên file save
const SAVE_FILE_NAME := "save.json"
# Khóa bảo mật để mã hóa file
const SECURITY_KEY = "213HOOS"

func _ready():
	# Kiểm tra và tạo thư mục lưu trữ nếu chưa tồn tại
	verify_save_directory(SAVE_DIR)


func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)


func save_data_player(player_data: PlayerData):
	var path = SAVE_DIR + SAVE_FILE_NAME
	
	# Mở hoặc tạo một file ở đường dẫn chỉ định với mã hóa bằng khóa bảo mật
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_KEY)
	if file == null:
		printerr(FileAccess.get_open_error())
		return

	# Chuẩn bị dữ liệu người chơi để lưu vào file
	var data = {
		"player_data": {
			"health": player_data.health,
			"global_position": {
				"x": player_data.global_position.x,
				"y": player_data.global_position.y
			},
			"coins": player_data.coins,
			"current_scene": player_data.current_scene,
			"new_game": player_data.new_game
		}
	}

	# Chuyển đổi dữ liệu thành chuỗi JSON với lịch sử
	var json_string = JSON.stringify(data, "\t")
	# Ghi chuỗi JSON vào file
	file.store_string(json_string)
	# Đóng file
	file.close()

func load_data_player() -> PlayerData:
	var path = SAVE_DIR + SAVE_FILE_NAME
	var player_data = PlayerData.new()
	
	if FileAccess.file_exists(path):
		# Mở file đã tồn tại với mã hóa bằng khóa bảo mật để đọc
		var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_KEY)
		if file == null:
			print(FileAccess.get_open_error())
			return

		# Đọc nội dung của file
		var content = file.get_as_text()
		# Đóng file
		file.close()

		# Giải mã chuỗi JSON thành dữ liệu
		var data = JSON.parse_string(content)
		if data == null:
			printerr("Cannot parse %s as a json_string: (%s)" % [path, content])
			return

		# Cập nhật dữ liệu người chơi từ dữ liệu đã tải
		player_data.health = data.player_data.health
		player_data.global_position = Vector2(data.player_data.global_position.x, data.player_data.global_position.y)
		player_data.coins = data.player_data.coins
		player_data.current_scene = data.player_data.current_scene
		player_data.new_game = data.player_data.new_game
	else:
		printerr("Cannot open non-existent file as %s!" % [path])

	return player_data
