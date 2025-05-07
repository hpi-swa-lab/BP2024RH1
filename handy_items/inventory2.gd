# To change the position and size of the Inventory slots you need to change the number of columns 
# or resize the Gridcontainer. If you want more slots increase the slotCount

extends Control

var slotCount = 8
var opened: bool = true
var columns = 2
var slots: Array

func _ready() -> void:
	var newSlot: Control
	var slotScene: PackedScene
	
	%GridContainer.columns = columns
	for i in range(slotCount):
		slotScene = load("res://inventory_slot.tscn")
		newSlot = slotScene.instantiate()
		newSlot.custom_minimum_size = Vector2(%GridContainer.size.x / columns, %GridContainer.size.x / columns)
		%GridContainer.add_child(newSlot)
	slots = %GridContainer.get_children()
	
	update_inventory()

func add_item(Item: Button):
	for slot in slots:
		if slot.StoredItem == null:
			slot.add_item(Item)
			break

func _on_button_pressed() -> void:
	if opened:
		%Control.hide()
		opened = false
		%Button.text = "Show"
	else:
		%Control.show()
		opened = true
		%Button.text = "Hide"
		
func update_inventory():
	for slot in slots:
		if slot.StoredItem != null:
			slot.remove_item()
	for item in GlobalInventory.Items:
		add_item(GlobalInventory.Items[item])
