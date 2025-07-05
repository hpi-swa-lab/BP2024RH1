extends Control

var ziel_input: bool  = false
var current_active_starts: int = 0


@onready var level_2: Control = $Level2
	#DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "act2PuzzleInfo1"


func _ready() -> void:
	current_active_starts = 0
	#GlobalTimer.add_log_entry("entered scene: minigame_2")

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
	if level_2.current_active_starts <= 3:
		print(level_2.current_active_starts)
		if ziel_input:
			print("wlan funktioniert") 
			#GlobalTimer.end_timer("Logik Gatter Mini Games")
			get_tree().change_scene_to_file("res://Cases/A_Completely_Normal_Day/Scenes/police_station_rooms/office_end.tscn")
			# Hier muss noch der Dialog eingefügt werden.
			#DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "act2PuzzleFinished")

		#übergang zu akt 2 plus dialog start das es geschafft wurde
	else:
		pass
		# Hier muss noch Dialog hinzugefügt werden
		#DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "act2PuzzleInfo2")
		#dialog das system bei mehr als drei satrts an überlasstet --> kurzversion von anfang bevor minigame startet
