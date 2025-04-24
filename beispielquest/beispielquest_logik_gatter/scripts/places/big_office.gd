extends Control

signal computer_1_pressed
signal computer_2_pressed
signal computer_3_pressed

signal router_1_pressed
signal router_2_pressed
signal router_3_pressed


func _on_computer_1_pressed() -> void:
	emit_signal("computer_1_pressed")


func _on_computer_2_pressed() -> void:
	emit_signal("computer_2_pressed")


func _on_computer_3_pressed() -> void:
	emit_signal("computer_3_pressed")


func _on_router_1_pressed() -> void:
	emit_signal("computer_1_pressed")


func _on_router_2_pressed() -> void:
	emit_signal("computer_2_pressed")


func _on_router_3_pressed() -> void:
	emit_signal("computer_3_pressed")
	
