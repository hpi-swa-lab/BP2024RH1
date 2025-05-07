extends Node

var InventoryScene: PackedScene = load("res://inventory2.tscn")
var InventoryInstance
var Items = {}

func get_inventory() -> Control:
	InventoryInstance = InventoryScene.instantiate()
	return InventoryInstance

func add_item(Item: Button):
	if not Items.has(Item.name):
		InventoryInstance.add_item(Item)
		var duplicatedItem = Item.duplicate()
		Items[duplicatedItem.name] = duplicatedItem
	else:
		print("you already collected this item")
