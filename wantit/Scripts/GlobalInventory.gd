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
		var duplicatedItem = Item.duplicate()
		if InventoryInstance:
			InventoryInstance.add_item(duplicatedItem)
		Items[duplicatedItem.name] = duplicatedItem

func show_inventory():
	InventoryInstance.show_inventory()
	
func hide_inventory():
	InventoryInstance.hide_inventory()
