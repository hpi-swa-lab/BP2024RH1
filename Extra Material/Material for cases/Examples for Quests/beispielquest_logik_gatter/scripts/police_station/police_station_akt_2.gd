extends Control

func _ready() -> void:
	GlobalTimer.add_log_entry("entered scene: akt_2")
	DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "introRouterError")


func _on_tech_room_electricity_box_pressed() -> void:
	pass # Replace with function body.
