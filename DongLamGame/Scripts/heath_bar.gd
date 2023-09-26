extends ProgressBar
class_name HeathBar

func play_dead_sound():
	$DeadSound.play()

func play_plus_heath_sound():
	$PlusHeathSound.play()
	
func play_minus_heath_sound():
	$MinusHeathSound.play()
