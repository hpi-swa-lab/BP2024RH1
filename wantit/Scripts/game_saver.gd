extends RefCounted
class_name GameSaver

const SAVE_PATH := "user://progress.json"

func save_game(game: Game):
	var save_data = game.get_save_data()
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data, "\t"))
	file.flush()
	file.close()
	
	if OS.has_feature("HTML5"):
		JavaScriptBridge.eval("FS.syncfs(false, function(err) { console.log('Save synced:', err); });")
	
func load_saved_game_data(game: Game):
	if OS.has_feature("HTML5"):
		JavaScriptBridge.eval("FS.syncfs(true, function(err) { console.log('Load synced:', err); });")
	
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
	
	game.saved_game_data = result
