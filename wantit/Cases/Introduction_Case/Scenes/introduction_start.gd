extends Node2D

func _ready() -> void:
	# Setting Globals
	Globals.OfficeDialogue = "res://dialogue/dialogue.dialogue"
	Globals.OfficeDialogueStart = "start_case"
	CaseManager.new_Location(load("res://Cases/Caesar/Assets/Haus_icon.png"), Vector2(0.1, 0.1), Vector2(130, 100), preload("res://Cases/Introduction_Case/Scenes/showroom.tscn"))
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")
	GlobalTimer.start_timer("insgesamt")
