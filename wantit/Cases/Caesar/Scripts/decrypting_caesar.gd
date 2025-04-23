extends Node2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Decrypting.dialogue"), "start")

func go_back() -> void:
	CaseManager.new_Location(preload("res://Cases/Caesar/Assets/Restaurant_icon.png"), Vector2(0.1, 0.1), Vector2(-100, -100), preload("res://Cases/Caesar/Scenes/restaurant.tscn"))
	
	Globals.OfficeDialogueStart = "Teil4"
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")

func _on_minispiel_solved(value: bool) -> void:
	if value:
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Decrypting.dialogue"), "zurueck")
	else:
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Decrypting.dialogue"), "falsch")

func _on_open_inventory_pressed() -> void:
	%Camera2D.position = Vector2(1500, 0)

func _on_close_inventory_pressed() -> void:
	%Camera2D.position = Vector2(0, 0)
