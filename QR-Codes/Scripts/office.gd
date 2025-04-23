extends Node2D

@export var colour: ColorRect

func _ready() -> void:
	if not Global.Intro_done:
		DialogueManager.show_example_dialogue_balloon(load ("res://dialogue/main.dialogue"), "start")
	if Global.End == true:
		DialogueManager.show_example_dialogue_balloon(load ("res://dialogue/main.dialogue"), "end_scene")
		
func _process(delta):
	if Global.Colour == "green":
		colour.color = Color(0.0, 1.0, 0.0)
	if Global.Colour == "red":
		colour.color = Color(1.0, 0.0, 0.0)

func _on_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if Global.Intro_done and not Global.End:
			get_tree().change_scene_to_file("res://Scenes/Game.tscn")
