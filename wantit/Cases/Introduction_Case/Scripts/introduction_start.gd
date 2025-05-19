extends Node2D

func _ready() -> void:
	# Setting Globals
	Globals.OfficeDialogue = "res://dialogue/dialogue.dialogue"
	Globals.OfficeDialogueStart = "start_case"
	Globals.OfficeDialogueDone = false
	CaseManager.new_Location(load("res://Assets/map/bakery_map.png"), preload("res://Cases/Introduction_Case/Scenes/showroom.tscn"))
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")
