extends Node2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Täter.dialogue"), "start")

func go_back():
	Globals.OfficeDialogueStart = "Teil5"
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")

func end_it():
	SceneSwitcher.switch_scene("res://Cases/Caesar/Scenes/ende.tscn")
