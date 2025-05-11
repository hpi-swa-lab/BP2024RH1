extends Control

func _ready() -> void:
	Globals.npc_icon = load("res://Assets/character_selection/npc.png")
	
func _on_portrait_pressed() -> void:
	%Button.visible = true


func _on_button_pressed() -> void:
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")
