extends Control

@onready var menu = $Menu
@onready var options = $Options
@onready var video = $Video
@onready var audio = $Audio


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()

func toggle():
	visible = !visible
	get_tree().paused = visible


func _on_start_pressed():
	toggle()
	get_tree().change_scene_to_file("res://Prefabs/MainMenu.tscn")


func _on_option_pressed():
	show_and_hide(options, menu)


func show_and_hide(first, second):
	first.show()
	second.hide()


func _on_exit_pressed():
	get_tree().quit()


func _on_video_pressed():
	show_and_hide(video, options)


func _on_audio_pressed():
	show_and_hide(audio,options)


func _on_back_from_options_pressed():
	show_and_hide(menu, options)


func _on_full_screen_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_borderless_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_v_sync_toggled(button_pressed):
	DisplayServer.window_set_vsync_mode(button_pressed)


func _on_back_from_video_pressed():
	show_and_hide(options, video)


func _on_master_value_changed(value):
	volume(0, value)


func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)


func _on_music_value_changed(value):
	volume(1, value)


func _on_sound_fx_value_changed(value):
	volume(2, value)


func _on_back_from_audio_pressed():
	show_and_hide(options, audio)

