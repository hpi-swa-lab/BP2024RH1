extends Node2D

var dialogue = "Tatort"


func start_scene():
	if Global.CrimeScene_visited == false:
		DialogueManager.show_dialogue_balloon(load("res://dialogues/Tatort.dialogue"), "start")
	
	
func go_back() -> void:
	SceneSwitcher.switch_to_scene("res://Scenes/büro.tscn")

func _on_button_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogues/Tatort.dialogue"), "zurueck") 
	# hier wird ein normaler Button statt dem ScenSwitcherButton benutzt, wegen dem Dialog. Da war ich zu faul das zu ändern

#func _on_tür_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
#	if event is InputEventMouseButton:
#		SceneSwitcher.switch_scene("res://Scenes/küche.tscn")
