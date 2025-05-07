extends Control

var searching: bool

func _ready() -> void:
	var Inventory = GlobalInventory.get_inventory()
	Inventory.position = Vector2(908, 0)
	add_child(Inventory)

func _on_lupe_searching(start: bool) -> void:
	searching = start

func _input(event):			# Needs to be copied when using the magnifying glass elsewhere
	if event is InputEventMouseButton and searching:
		for child in %Items.get_children():
			if child.position.distance_to(event.position) < 300:
				child.highlight()


func _on_button_3_pressed() -> void:
	%Inventory.open()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://testscene_2.tscn")
