extends CanvasLayer

@onready var main_scene : MainScene = $"../.."
@onready var txt_coin = $Control/TxtCoin
@onready var bar_hp = $BarHP
@onready var bar_mp = $BarMP

@export var player : Player

var save_file_path = "res://save/"
var save_file_name = "PlayerSave.tres"
var coin
var hp


func _ready():
	update_label()


func _process(delta):
	if coin != str(player.coin) || hp != player.hp:
		update_label()


func update_label():
	coin = str(player.coin)
	hp = player.remaining_hp() * 100
	
	txt_coin.text = coin
	bar_hp.value = hp
