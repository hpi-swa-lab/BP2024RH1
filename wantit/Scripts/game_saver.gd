extends RefCounted

class_name GameSaver

const SAVE_PATH := "user://progress.json"

func save_game(game: Game):
	var save_data = {
		"active_case_slug": game.active_case_slug,
		"completed_cases": game.get_completed_cases(),
		"inventory": game.inventory.get_items_name(),
		"interactions": game.interactions
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data, "\t"))
	file.close()
	#print("Game saved to: ", SAVE_PATH)
	
func load_game(game: Game):
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
	
	game.active_case_slug = result.get("active_case_slug", "")
	game.set_completed_cases(result.get("completed_cases", []))
	game.interactions = result.get("interactions", [])
	var inventory_items_name = result.get("inventory", [])
	if inventory_items_name:
		#TODO restore items from their names
		pass 

	#print("Game loaded from: ", SAVE_PATH)
