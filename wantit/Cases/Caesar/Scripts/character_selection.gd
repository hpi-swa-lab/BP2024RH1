extends Control

@onready var scene_switcher_button: Button = $SceneSwitcherButton

func _ready() -> void:
	scene_switcher_button.process_mode = Node.PROCESS_MODE_DISABLED
	scene_switcher_button.visible = false
	
func _on_portrait_pressed() -> void:
	print("Character selected")
	scene_switcher_button.process_mode = Node.PROCESS_MODE_INHERIT
	scene_switcher_button.visible = true
	Globals.OfficeDialogue = "res://Cases/Caesar/dialogues/Büro_1.dialogue"
	Globals.OfficeDialogueStart = "start"
	CaseManager.new_Location(preload("res://Assets/library.png"), Vector2(0.1, 0.1), Vector2(130, 100), preload("res://Cases/Caesar/Scenes/tatort.tscn"))	
