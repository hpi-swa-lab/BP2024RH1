# To change the position and size of the Inventory slots you need to change the number of columns 
# or resize the Gridcontainer. If you want more slots increase the slotCount

extends Control
#extends Node
class_name Inventory

var inventory_slots: Array[InventorySlot] = []
var inventory_items_names: Array[String] = []
var clue_dictionary: Dictionary
@export var slot_count: int = 8
@export var columns: int  = 2
@export var slot_scene: PackedScene
@onready var grid_container: GridContainer = %GridContainer
var opened: bool = true


func _ready() -> void:
	grid_container.columns = columns
	for i in range(slot_count):
		var slot = slot_scene.instantiate() as InventorySlot
		print("Inventory slot appended!")
		inventory_slots.append(slot)
		grid_container.add_child(slot)
		
		slot.custom_minimum_size = Vector2(
			grid_container.size.x / columns,
			grid_container.size.x / columns
		)
		#slotScene = load("res://Scenes/inventory_slot.tscn")
		#newSlot = slotScene.instantiate()
		#newSlot.custom_minimum_size = Vector2(%GridContainer.size.x / columns, %GridContainer.size.x / columns)
		#%GridContainer.add_child(newSlot)
	#slots = %GridContainer.get_children()
	
	#update_inventory()
	#hide_inventory()

func add_item(item: Clue) -> void:
	for slot in inventory_slots:
		if slot.is_empty():
			print("Empty slot found!")
			slot.add_item(item)

func _on_button_pressed() -> void:
	if opened:
		hide_inventory()
	else:
		show_inventory()
		
func update_inventory(): 
	if inventory_items_names:
		var restored_inventory_items = restore_inventory_items(clue_dictionary)
		for item in restored_inventory_items:
			add_item(item)

func show_inventory():
	%Control.show()
	opened = true
	%Button.text = "Schließen"
	
func hide_inventory():
	%Control.hide()
	opened = false
	%Button.text = "Inventar"


#func get_items() -> Array[String]:  
	#var items = []
	#for slot in slots:
		#if slot.StoredItem:
			#items.push_back(slot.StoredItem.clue_name)
	#return items

func get_inventory_items_name() -> Array[String]:
	var items_name: Array[String] = []
	for slot in inventory_slots:
		if slot.stored_item != null:
			items_name.append(slot.stored_item.clue_name)
	return items_name
	
func restore_inventory_items(clue_dictionary: Dictionary) -> Array[Clue]:
	var inventory_items: Array[Clue] = []
	##inventory_items.clear() #is it necessary?
	for item in inventory_items_names:
		if clue_dictionary.has(item):
			inventory_items.append(clue_dictionary[item])
		else:
			push_error("Missing object for id: %s" % item)
	return inventory_items
