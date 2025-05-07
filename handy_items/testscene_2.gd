extends Node2D

func _ready() -> void:
	var Inventory = GlobalInventory.get_inventory()
	Inventory.position = Vector2(908, 0)
	add_child(Inventory)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")
