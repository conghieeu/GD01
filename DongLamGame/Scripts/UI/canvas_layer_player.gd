extends CanvasLayer

@export var player: Player

var coin

func _ready():
	SaveSystem.load_data()
	coin = SaveSystem.coin

func _process(delta):
	$BarHP.value = player.remaining_hp() * 100
	$BarMP.value = player.remaining_mp() * 100
	
	if coin != player.coin:
		coin = player.coin
		$Control/TxtCoin.text = str(coin)
		SaveSystem.save()
