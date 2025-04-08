extends Node2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogues/Täter.dialogue"), "start")

func go_back():
	SceneSwitcher.switch_scene("res://Scenes/büro.tscn")

func end_it():
	SceneSwitcher.switch_scene("res://Scenes/ende.tscn")
