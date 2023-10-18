extends Control
class_name ScoresPanel

func toggle():
	visible = !visible
	LoadValue()

func LoadValue():
	var playerData = PlayerData.new()
	playerData = SaveGame.load_data_player()
	
	$Label.text = "Coins : " + str(playerData.coins);

func _on_back_pressed():
	toggle()


func _on_btn_scores_pressed():
	toggle()
