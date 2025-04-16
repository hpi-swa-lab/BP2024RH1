extends Node2D

func _ready() -> void:
	DialogueManager.show_example_dialogue_balloon(load ("res://dialogue/main.dialogue"), "start")

func _on_button_pressed() -> void:
	Global.Options = 1
	SceneSwitcher.switch_scene("res://Scenes/Game.tscn")


func _on_button_2_pressed() -> void:
	Global.Options = 2
	SceneSwitcher.switch_scene("res://Scenes/Game.tscn")
