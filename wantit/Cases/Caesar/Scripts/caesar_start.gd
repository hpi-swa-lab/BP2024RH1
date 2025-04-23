extends Node2D

func _ready() -> void:
	# Setting Globals
	Globals.OfficeDialogue = "res://Cases/Caesar/dialogues/Büro_1.dialogue"
	Globals.OfficeDialogueStart = "start"
	CaseManager.new_Location(preload("res://Cases/Caesar/Assets/Haus_icon.png"), Vector2(0.1, 0.1), Vector2(130, 100), preload("res://Cases/Caesar/Scenes/tatort.tscn"))	
	
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")
