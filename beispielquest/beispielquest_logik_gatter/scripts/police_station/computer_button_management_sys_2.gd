extends Node


func _on_office_computer_pressed() -> void:
	_show_dialogue()

func _on_head_office_computer_pressed() -> void:
	_show_dialogue()


func _on_big_office_computer_1_pressed() -> void:
	_show_dialogue()


func _on_big_office_computer_2_pressed() -> void:
	_show_dialogue()


func _on_big_office_computer_3_pressed() -> void:
	_show_dialogue()


func _on_kitchen_computer_pressed() -> void:
	_show_dialogue()

func _show_dialogue() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogue/logik_gatter.dialogue"), "computerError2")
