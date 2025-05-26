# To change the position and size of the Inventory slots you need to change the number of columns 
# or resize the Gridcontainer. If you want more slots increase the slotCount

extends Control

class_name Inventory

var items: Array[Clue] = []

var slotCount = 8
var opened: bool = true
var columns = 2
var slots: Array

func _ready() -> void:
	var newSlot: Control
	var slotScene: PackedScene
	
	%GridContainer.columns = columns
	for i in range(slotCount):
		slotScene = load("res://Scenes/inventory_slot.tscn")
		newSlot = slotScene.instantiate()
		newSlot.custom_minimum_size = Vector2(%GridContainer.size.x / columns, %GridContainer.size.x / columns)
		%GridContainer.add_child(newSlot)
	slots = %GridContainer.get_children()
	
	update_inventory()
	hide_inventory()

func add_item(Item: Clue):
	for slot in slots:
		if slot.StoredItem == null:
			slot.add_item(Item)
			break

func _on_button_pressed() -> void:
	if opened:
		hide_inventory()
	else:
		show_inventory()
		
func update_inventory():
	for item in GlobalInventory.Items:
		add_item(GlobalInventory.Items[item])
		
func show_inventory():
	%Control.show()
	opened = true
	%Button.text = "Schließen"
	
func hide_inventory():
	%Control.hide()
	opened = false
	%Button.text = "Inventar"

func get_items() -> Array[String]:  
	var items = []
	for slot in slots:
		if slot.StoredItem:
			items.push_back(slot.StoredItem.clue_name)
	return items

func get_inventory_items_name() -> Array[String]:
	var items_name = []
	for item in items:
		items_name.append(item.clue_name)
	return items_name
