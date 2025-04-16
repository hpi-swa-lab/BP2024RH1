extends Node2D

func _ready() -> void:
	DialogueManager.show_example_dialogue_balloon(load ("res://dialogue/main.dialogue"), "start")

func _on_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		SceneSwitcher.switch_scene("res://Scenes/game.tscn")
