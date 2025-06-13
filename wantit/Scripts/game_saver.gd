extends RefCounted
class_name GameSaver

const SAVE_PATH := "user://progress.json"

func save_game(game: Game):
	var save_data = {
		"active_case_slug": game.active_case_slug,
		"current_location_name": game.current_location.location_name,
		#"completed_cases": game.get_completed_cases(),
		"inventory_items": game.get_case_inventory(),
		"interactions": game.get_case_interactions(),
		"dialogues": game.get_played_dialogues()
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data, "\t"))
	file.close()
	
func load_saved_game_data(game: Game):
	if not FileAccess.file_exists(SAVE_PATH):
		print("Save file not found.")
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	
	var result = JSON.parse_string(content)
	if typeof(result) != TYPE_DICTIONARY:
		print("Failed to parse save file.")
		return
	
	game.restored_game_data = result
