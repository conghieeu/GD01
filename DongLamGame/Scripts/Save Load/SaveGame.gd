class_name SaveGame
extends Resource

const SAVE_GAME_PATH := "res://savegame.tres"

@export var character: Resource
@export var inventory: Resource
@export var map_name := ""
@export var global_position := Vector2.ZERO

func write_savegame():
	ResourceSaver.save(self, SAVE_GAME_PATH)

static func load_savegame() -> Resource:
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH)
	return null
