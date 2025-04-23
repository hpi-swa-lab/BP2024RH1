extends Node2D

func _on_button_pressed() -> void:
	Global.Options = 1
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_button_2_pressed() -> void:
	Global.Options = 2
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
