extends Control

signal Computer_pressed

func _on_computer_pressed() -> void:
	emit_signal("Computer_pressed")
