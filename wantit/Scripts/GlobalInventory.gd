extends Node

var InventoryScene: PackedScene = load("res://Scenes/inventory.tscn")
var InventoryInstance
var Items = {}

var TextureCache = {}

func get_inventory() -> Control:
	InventoryInstance = InventoryScene.instantiate()
	return InventoryInstance

func add_item(Item: TextureButton):
	if not Items.has(Item.name):
		if InventoryInstance:
			InventoryInstance.add_item(Item)
		var duplicatedItem = Item.duplicate()
		Items[duplicatedItem.name] = duplicatedItem
	else:
		print("you already collected this item")
