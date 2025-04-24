extends Node2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Täter.dialogue"), "start")

func go_back():
	Globals.OfficeDialogueStart = "Teil5"
	CaseManager.add_Hint(Vector2(600, 200), preload("res://Cases/Caesar/Assets/npc.png"), Vector2(0.7, 0.7))
	CaseManager.add_Hint(Vector2(700, 500), preload("res://Cases/Caesar/Assets/Geheim.png"), Vector2(0.8, 0.8))
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")

func close_case():
	SceneSwitcher.switch_scene("res://Cases/Caesar/Scenes/ende.tscn")
