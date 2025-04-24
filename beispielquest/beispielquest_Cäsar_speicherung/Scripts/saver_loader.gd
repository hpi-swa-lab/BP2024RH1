extends Node

const SAVE_PATH := "res://progress.json"

func save_game():
	var save_data = {
		"global": {
			"character_portrait_path": Global.character_portrait_path,
			"current_scene": Global.last_visited_scene,
			"items_found": Global.items_found
		},
		"scenes": {
			"tatort": {
				"Caesar_picked": Global.Caesar_picked,
				"Businesskarte_picked": Global.Businesskarte_picked,
				"Bild_picked": Global.Bild_picked
			},
			"küche": {
				"Fenster_picked": Global.Fenster_picked,
				"Nachricht_picked": Global.Nachricht_picked,
				"Papierkorb_picked": Global.Papierkorb_picked
			},
			"büro": {
				"office_szene" : Global.office_szene
			},
			"minispiel": {
				
			},
			"restaurant": {
				
			}
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
	
	
	if result.has("global"):
		var global_data = result["global"]
		Global.character_portrait_path = global_data.get("character_portrait_path", "")
		Global.last_visited_scene = global_data.get("current_scene", "")
		Global.items_found = global_data.get("items_found", "")
	else:
		print("ℹ️ No global data found in save file.")

	if result.has("scenes"):
		var scenes_data = result["scenes"]

		if scenes_data.has("tatort"):
			var tatort = scenes_data["tatort"]
			Global.Caesar_picked = tatort.get("Caesar_picked", false)
			Global.Businesskarte_picked = tatort.get("Businesskarte_picked", false)
			Global.Bild_picked = tatort.get("Bild_picked", false)
		else:
			print("ℹ️ No data for scene: tatort")
			
		if scenes_data.has("küche"):
			var kueche = scenes_data["küche"]
			Global.Fenster_picked = kueche.get("Fenster_picked", false)
			Global.Nachricht_picked = kueche.get("Nachricht_picked", false)
			Global.Papierkorb_picked = kueche.get("Papierkorb_picked", false)
		else:
			print("ℹ️ No data for scene: küche")
		
		if scenes_data.has("büro"):
			var buero = scenes_data["büro"]
			Global.office_szene = buero.get("office_szene", false)
		else:
			print("ℹ️ No data for scene: büro")

	print("✅ Game loaded successfully.")
	
	
func clear_save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string("{}")
	file.close()
	
	print("✅ Save file cleared.")
	
	
func start_new_game():
	SceneSwitcher.switch_scene("res://Scenes/game.tscn")
