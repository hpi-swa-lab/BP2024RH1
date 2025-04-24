extends Node2D

func _ready() -> void:
	Global.last_visited_scene = "res://Scenes/tutorial.tscn"
	GameSaver.save_game()
	
	Global.had_tutorial = true
	DialogueManager.show_dialogue_balloon(load("res://dialogues/Tutorial.dialogue"), "start")

func _process(_delta: float) -> void:
	if Global.caesar_decrypted == true:
		DialogueManager.show_dialogue_balloon(load("res://dialogues/Tutorial.dialogue"), "zurueck")
		Global.caesar_decrypted = false

func go_back() -> void:
	SceneSwitcher.switch_scene("res://Scenes/büro.tscn")
	Global.caesar_decrypted = false
