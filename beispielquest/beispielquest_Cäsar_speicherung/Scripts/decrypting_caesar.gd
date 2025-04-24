extends Node2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogues/Decrypting.dialogue"), "start")

func _process(_delta: float) -> void:
	if Global.caesar_decrypted == true:
		DialogueManager.show_dialogue_balloon(load("res://dialogues/Decrypting.dialogue"), "zurueck")
		Global.caesar_decrypted = false

func go_back() -> void:
	SceneSwitcher.switch_scene("res://Scenes/büro.tscn")
	Global.caesar_decrypted = true
