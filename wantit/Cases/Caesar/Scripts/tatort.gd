extends Node2D

var dialogue = "Tatort"
var Window_clicked: bool = false

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Tatort.dialogue"), "start")
	
func go_back() -> void:
	Globals.OfficeDialogueStart = "Teil2"
	CaseManager.new_Location(preload("res://Assets/library.png"), Vector2(0.1, 0.1), Vector2(130, 100), preload("res://Cases/Caesar/Scenes/restaurant.tscn"))
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")

func _on_fenster_abdrücke_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and Window_clicked == false:
		Globals.items_found += 1
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Küche.dialogue"), "Fenster")
		Window_clicked = true

func _on_go_back_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Tatort.dialogue"), "zurueck") 

func _on_go_to_kitchen_pressed() -> void:
	%Camera2D.position = Vector2(1700, 0)

func _on_go_to_crime_scene_pressed() -> void:
	%Camera2D.position = Vector2(0, 0)
