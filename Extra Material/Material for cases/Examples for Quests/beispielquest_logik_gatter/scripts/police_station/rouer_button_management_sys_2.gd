extends Node


func _on_office_router_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "investigateRouter1")


func _on_head_office_router_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "investigateRouter2")


func _on_big_office_router_1_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "investigateRouter3")


func _on_big_office_router_2_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "investigateRouter4")


func _on_big_office_router_3_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "investigateRouter5")


func _on_tech_room_router_pressed() -> void:
	print("1")
	DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "investigateRouter1")


func _on_kitchen_router_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "investigateRouter3")
