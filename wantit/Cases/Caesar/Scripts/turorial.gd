extends Node2D

func _ready() -> void:
	Globals.had_tutorial = true
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Tutorial.dialogue"), "start")

func _process(_delta: float) -> void:
	if Globals.caesar_decrypted == true:
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Tutorial.dialogue"), "zurueck")
		Globals.caesar_decrypted = false

func go_back() -> void:
	Globals.OfficeDialogueStart = "Teil3"
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")
	Globals.caesar_decrypted = false
