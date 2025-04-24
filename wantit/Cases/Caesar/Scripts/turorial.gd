extends Node2D

func _ready() -> void:
	Globals.CaseGlobals.had_tutorial = true
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Tutorial.dialogue"), "start")

func go_back() -> void:
	Globals.OfficeDialogueStart = "Teil3"
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")

func _on_minispiel_solved(value: bool) -> void:
	if value:
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Tutorial.dialogue"), "zurueck")
	else:
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Tutorial.dialogue"), "falsch")
