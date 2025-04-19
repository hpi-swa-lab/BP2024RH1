extends Node2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Decrypting.dialogue"), "start")

func _process(_delta: float) -> void:
	if Globals.caesar_decrypted == true:
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Decrypting.dialogue"), "zurueck")
		Globals.caesar_decrypted = false

func go_back() -> void:
	CaseManager.new_Location(preload("res://Assets/library.png"), Vector2(0.1, 0.1), Vector2(130, 100), preload("res://Cases/Caesar/Scenes/restaurant.tscn"))
	Globals.OfficeDialogueStart = "Teil4"
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")
	Globals.caesar_decrypted = true
