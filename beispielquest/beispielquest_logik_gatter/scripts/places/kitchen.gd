extends Control

signal computer_pressed

func _on_computer_pressed() -> void:
	emit_signal("computer_pressed")
