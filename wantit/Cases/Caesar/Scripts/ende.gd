extends Node2D

func _ready() -> void:
	if Globals.CaseManager.optional_route:
		%"Option 1".position = Vector2(-200, 0)
		%"Option 2".position = Vector2(200, 0)
		%"Option 2".visible = true

func _on_option_1_end_dialogue(DialogueStart: String) -> void:
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Ende.dialogue"), DialogueStart)

func _on_option_2_end_dialogue(DialogueStart: String) -> void:
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Ende.dialogue"), DialogueStart)

func go_back():
	SceneSwitcher.switch_scene("res://Scripts/office.gd")
