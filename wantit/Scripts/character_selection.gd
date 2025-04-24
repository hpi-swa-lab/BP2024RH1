extends Control

@onready var scene_switcher_button: Button = $SceneSwitcherButton

func _ready() -> void:
	scene_switcher_button.process_mode = Node.PROCESS_MODE_DISABLED
	scene_switcher_button.visible = false
	Globals.npc_icon = load("res://Cases/Caesar/Assets/npc.png")
	
func _on_portrait_pressed() -> void:
	print("Character selected")
	scene_switcher_button.process_mode = Node.PROCESS_MODE_INHERIT
	scene_switcher_button.visible = true
