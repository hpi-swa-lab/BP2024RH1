extends Node2D

var dialogue = "Tatort"
var Window_clicked: bool = false

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Tatort.dialogue"), "start")
	
func go_back() -> void:
	CaseManager.add_Hint(Vector2(250, 150), preload("res://Cases/Caesar/Assets/caesar.png"), Vector2(0.3, 0.3))
	CaseManager.add_Hint(Vector2(500, 350), preload("res://Cases/Caesar/Assets/Restaurant_icon.png"), Vector2(0.2, 0.2))
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")

func _on_fenster_abdrücke_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and Window_clicked == false:
		Globals.CaseGlobals.items_found += 1
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Küche.dialogue"), "Fenster")
		Window_clicked = true

func _on_go_back_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Tatort.dialogue"), "zurueck") 

func _on_go_to_kitchen_pressed() -> void:
	%Camera2D.position = Vector2(1700, 0)

func _on_go_to_crime_scene_pressed() -> void:
	%Camera2D.position = Vector2(0, 0)
