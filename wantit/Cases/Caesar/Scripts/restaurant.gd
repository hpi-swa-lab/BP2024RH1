extends Node2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/Restaurant.dialogue"), "start")

func visit_culprit():
	SceneSwitcher.switch_scene("res://Cases/Caesar/Scenes/haus_2.tscn")
