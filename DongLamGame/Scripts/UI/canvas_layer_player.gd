extends CanvasLayer

@onready var main_scene = $"../.."
@onready var txt_coin = $Control/TxtCoin
@onready var bar_hp = $BarHP
@onready var bar_mp = $BarMP
@onready var player : Player

var save_file_path = "res://save/"
var save_file_name = "PlayerSave.tres"

var res_player = Res_Player.new()


func _ready():
	main_scene._load_game()
	res_player.coin = player.coin
	pass


func verify_save_directory(path):
	DirAccess.make_dir_absolute(path)


func update_label():
	bar_hp.value = player.remaining_hp() * 100
	bar_mp.value = player.remaining_mp() * 100

	if res_player.coin != player.coin:
		res_player.coin = player.coin
		txt_coin.text = res_player.coin
		main_scene._save_game()
		pass
