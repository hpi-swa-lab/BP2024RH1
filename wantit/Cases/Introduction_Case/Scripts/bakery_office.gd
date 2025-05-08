extends Control

func _ready() -> void:
	var Inventory = GlobalInventory.get_inventory()
	Inventory.position = Vector2(908, 0)
	add_child(Inventory)
