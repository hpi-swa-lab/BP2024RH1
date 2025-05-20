extends Control

var ziel_input: bool  = false

@onready var level_2: Control = $Level2

func _ready() -> void:
	GlobalTimer.start_timer("Logik Gatter Mini Games")
	DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "act2PuzzleInfo1")



func _on_check_button_pressed() -> void:
	if level_2.current_active_starts <= 3:
		print(level_2.current_active_starts)
		if ziel_input:
			print("wlan funktioniert") 
			GlobalTimer.end_timer("Logik Gatter Mini Games")
			DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "act2PuzzleFinished")

		#übergang zu akt 2 plus dialog start das es geschafft wurde
	else:
		DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "act2PuzzleInfo2")
		#dialog das system bei mehr als drei satrts an überlasstet --> kurzversion von anfang bevor minigame startet

func _on_level_2_ziel_input_false() -> void:
	ziel_input = false	

func _on_level_2_ziel_input_true() -> void:
	ziel_input = true
