extends Node2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogues/Restaurant.dialogue"), "start")

func visit_culprit():
	SceneSwitcher.switch_scene("res://Scenes/haus_2.tscn")
