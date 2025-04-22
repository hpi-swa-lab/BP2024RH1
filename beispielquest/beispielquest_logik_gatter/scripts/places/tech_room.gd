extends Control

signal electricity_box_pressed



func _on_electricity_box_pressed() -> void:
	emit_signal("electricity_box_pressed")
