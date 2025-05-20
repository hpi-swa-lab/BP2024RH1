extends Node
@onready var dark_mode_blackout: Sprite2D = $"../Dark_Mode_Blackout"

func _on_office_router_pressed() -> void:
	_show_dialogue() # Replace with function body.

func _on_head_office_router_pressed() -> void:
	_show_dialogue() # Replace with function body.

func _on_big_office_router_1_pressed() -> void:
	_show_dialogue() # Replace with function body.

func _on_big_office_router_2_pressed() -> void:
	_show_dialogue() # Replace with function body.

func _on_big_office_router_3_pressed() -> void:
	_show_dialogue() # Replace with function body.

func _on_tech_room_router_pressed() -> void:
	_show_dialogue() # Replace with function body.

func _on_kitchen_router_pressed() -> void:
	_show_dialogue() # Replace with function body.

func _show_dialogue() -> void:
	if dark_mode_blackout.visible:
		DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "routerError")
