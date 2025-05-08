extends Node

const SAVE_PATH := "user://progress.json"

func save_game():
	var save_data = {
		"global": {
			"character_portrait_path": Global.character_portrait_path,
			"current_scene_path": Global.current_scene_path
		},
		"case": {
			"dialogues_shown": Global.case.get("dialogues_shown", {}),
			"scene_collectables_found": Global.case.get("scene_collectables_found", {}),
			"scene_noncollectables_found": Global.case.get("scene_noncollectables_found", {}),
			"next_scene": Global.case.get("next_scene", "")
		}
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data, "\t"))  # Pretty print with tabs
	file.close()

	print("✅ Saved game to: ", SAVE_PATH)


func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("⚠️ No save file found.")
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var content = file.get_as_text()
	file.close()

	var result = JSON.parse_string(content)
	if typeof(result) != TYPE_DICTIONARY:
		print("❌ Failed to parse save file.")
		return
	
	
	# Global data loading
	if result.has("global"):
		var global_data = result["global"]
		Global.character_portrait_path = global_data.get("character_portrait_path", "")
		Global.current_scene_path = global_data.get("current_scene_path", "")
	else:
		print("ℹ️ No global data found in save file.")

	# Case data loading
	if result.has("case"):
		var case_data = result["case"]
		Global.case.dialogues_shown = case_data.get("dialogues_shown", {})
		Global.case.scene_collectables_found = case_data.get("scene_collectables_found", {})
		Global.case.scene_noncollectables_found = case_data.get("scene_noncollectables_found", {})
		Global.case.next_scene = case_data.get("next_scene", "")
	else:
		print("ℹ️ No case data found in save file.")

	
	print("✅ Game loaded successfully.")
