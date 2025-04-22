extends Control

signal start_1
signal start_2


func _on_start_and_left_1_pressed() -> void:
	emit_signal("start_1")

func _on_start_and_left_2_pressed() -> void:
	emit_signal("start_2")
