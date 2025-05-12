extends Control

func _ready() -> void:
	var Inventory = GlobalInventory.get_inventory()
	add_child(Inventory)
