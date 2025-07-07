extends Location

var ziel_input: bool = false

func _on_ziel_ziel_input_false() -> void:
	ziel_input = false

func _on_ziel_ziel_input_true() -> void:
	ziel_input = true

func _ready() -> void:
	#GlobalTimer.add_log_entry("entered scene: minigame_1")
	pass

func _on_check_pressed() -> void:
	if ziel_input == true:
		#GlobalTimer.end_timer("Logik Gatter Mini Games")
		var interaction_item_log_minigame_1_complete = Item.new()
		interaction_item_log_minigame_1_complete.item_name = "log_minigame_1_complete"
		item_found.emit(interaction_item_log_minigame_1_complete)
		print("log_minigame_1_complete_akwjgerfesuhkjfh")
	else:
		DialogueManager.show_dialogue_balloon(load("res://Cases/A_Completely_Normal_Day/dialogue/minigame_2.dialogue"), "Ziel_input_false")
