extends Minigame

var ziel_input: bool  = false
var current_active_starts: int = 0


#DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "act2PuzzleInfo1")


func _ready() -> void:
	super._ready()
	current_active_starts = 0

func _on_ziel_ziel_input_false() -> void:
	ziel_input = false	

func _on_ziel_ziel_input_true() -> void:
	ziel_input = true


func _on_start_or_right_toggled(toggled_on: bool) -> void:
	update_current_active_starts(toggled_on)


func _on_start_or_left_toggled(toggled_on: bool) -> void:
	update_current_active_starts(toggled_on)


func _on_start_and_left_toggled(toggled_on: bool) -> void:
	update_current_active_starts(toggled_on)


func _on_start_for_two_or_left_and_right_toggled(toggled_on: bool) -> void:
	update_current_active_starts(toggled_on)


func _on_start_for_two_and_kitchen_or_right_toggled(toggled_on: bool) -> void:
	update_current_active_starts(toggled_on)


func update_current_active_starts(toggled_on: bool) -> void:
	if toggled_on:
		current_active_starts += 1
	else:
		current_active_starts -= 1
	print(current_active_starts)
	

func _on_check_pressed() -> void:
	if current_active_starts <= 3:
		print(current_active_starts)
		if ziel_input:
			print("wlan funktioniert") 
			var interaction_item_log_minigame_2_complete = Item.new()
			interaction_item_log_minigame_2_complete.item_name = "log_minigame_2_complete"
			item_found.emit(interaction_item_log_minigame_2_complete)
	else:
		pass
		DialogueManager.show_dialogue_balloon(load("res://Cases/A_Completely_Normal_Day/dialogue/minigame_2.dialogue"), "Hint")
	if ziel_input == false:
		DialogueManager.show_dialogue_balloon(load("res://Cases/A_Completely_Normal_Day/dialogue/minigame_2.dialogue"), "Ziel_input_false")
