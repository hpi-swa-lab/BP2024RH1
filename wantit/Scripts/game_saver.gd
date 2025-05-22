extends RefCounted

class_name GameSaver

const SAVE_PATH := "user://progress.json"

func save_game(game: Game):
	var save_data = {
		"active_case_slug": game.active_case_slug,
		"completed_cases": game.get_completed_cases()
		#"inventory": inventory.to_dict(),
		#"interactions": interactions.to_dict()
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
	
	# Restore basic fields
	game.active_case_slug = result.get("active_case_slug", "")
	game.set_completed_cases(result.get("completed_cases", []))
	
	# If you plan to restore inventory and interactions in the future:
	# game.inventory.from_dict(result.get("inventory", {}))
	# game.interactions.from_dict(result.get("interactions", {}))

	#print("Game loaded from: ", SAVE_PATH)
