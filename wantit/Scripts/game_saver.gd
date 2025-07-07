extends RefCounted
class_name GameSaver

const SAVE_PATH := "user://progress.json"
const SAVE_KEY := "my_game_save_data"

func save_game(game: Game):
	var save_data = game.get_save_data()
	
	if OS.has_feature("HTML5"):
		_save_to_local_storage(SAVE_KEY, save_data)
	else:
		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		file.store_string(JSON.stringify(save_data, "\t"))
		file.flush()
		file.close()
	
func load_saved_game_data(game: Game):
	var loaded_data = {}
	
	if OS.has_feature("HTML5"):
		loaded_data = _load_from_local_storage(SAVE_KEY)
	else:
		if not FileAccess.file_exists(SAVE_PATH):
			print("Save file not found.")
			return
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		var result = JSON.parse_string(content)
		if typeof(result) == TYPE_DICTIONARY:
			loaded_data = result
	
	if loaded_data.size() > 0:
		game.saved_game_data = loaded_data
	else:
		print("No saved data found.")


func _save_to_local_storage(key: String, data: Dictionary) -> void:
	if OS.has_feature("HTML5"):
		var json_string = JSON.stringify(data)
		var js_code = "localStorage.setItem('" + key + "', '" + json_string.replace("'", "\\'") + "');"
		JavaScriptBridge.eval(js_code)

func _load_from_local_storage(key: String) -> Dictionary:
	var js_code = "localStorage.getItem('" + key + "');"
	var result = JavaScriptBridge.eval(js_code)

	if result == null or result == "":
		return {}

	var parse_result = JSON.parse_string(result)
	if typeof(parse_result) == TYPE_DICTIONARY:
		return parse_result
	return {}
