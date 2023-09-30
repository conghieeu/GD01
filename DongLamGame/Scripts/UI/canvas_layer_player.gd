extends CanvasLayer

@export var player: Player

func _process(delta):
	$BarHP.value = player.remaining_hp() * 100
	$BarMP.value = player.remaining_mp() * 100
	$TxtCoin.text = str(player.coin)
