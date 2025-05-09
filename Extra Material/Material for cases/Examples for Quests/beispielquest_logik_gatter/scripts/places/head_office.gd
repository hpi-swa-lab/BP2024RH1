extends Control

signal computer_pressed
signal router_pressed

func _on_computer_pressed() -> void:
	emit_signal("computer_pressed")
	
	
func _on_router_pressed() -> void:
	emit_signal("router_pressed")
