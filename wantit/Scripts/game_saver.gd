extends RefCounted

class_name GameSaver

const SAVE_PATH := "user://progress.json"

func save_game():
	var active_case = Game.active_case
	var completed_cases = Game.completed_cases
	var inventory = Game.active_case.inventory
	var interactions = Game.active_case.interactions
	
	var save_data = {
		"active_case_id": active_case.case_id,
		"active_case_data": active_case.to_dict(),
		"completed_cases": completed_cases.map(func(case): return case.to_dict()),
		"inventory": inventory.to_dict(),
		"interactions": interactions.to_dict()
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data, "\t"))
	file.close()
	#print("Game saved to: ", SAVE_PATH)
	
func load_game():
	pass
