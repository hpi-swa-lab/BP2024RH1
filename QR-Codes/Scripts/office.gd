extends Node2D

@export var end_scene: Node2D

func _ready() -> void:
	if not Global.Intro_done:
		DialogueManager.show_example_dialogue_balloon(load ("res://dialogue/main.dialogue"), "start")
	if Global.End == true:
		end_scene.show_dialogue()

func _on_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if Global.Intro_done and not Global.End:
			get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func show_end_animal():
	end_scene.show_animal()
