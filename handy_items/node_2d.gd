extends Node2D

var searching: bool

func _on_lupe_searching(start: bool) -> void:
	searching = start

func _input(event):			# Needs to be copied when using the magnifying glass elsewhere
	if event is InputEventMouseButton and searching:
		for child in %Items.get_children():
			if child.position.distance_to(event.position) < 300:
				child.highlight()


func _on_button_3_pressed() -> void:
	%Inventory.open()
