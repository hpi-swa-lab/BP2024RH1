# To change the position and size of the Inventory slots you need to change the number of columns 
# or resize the Gridcontainer. If you want more slots increase the slotCount

extends Control
class_name Inventory

var inventory_slots: Array[InventorySlot] = []
var item_dictionary: Dictionary
@export var slot_count: int = 8
@export var columns: int  = 2
@export var slot_scene: PackedScene
@onready var grid_container: GridContainer = %GridContainer
var opened: bool = true

var _pending_restore_data: Array = []
var _restore_ready: bool = false


func _ready() -> void:
	_restore_ready = true
	
	grid_container.columns = columns
	for i in range(slot_count):
		var slot = slot_scene.instantiate() as InventorySlot
		slot.custom_minimum_size = Vector2(%GridContainer.size.x / columns, %GridContainer.size.x / columns)
		inventory_slots.append(slot)
		grid_container.add_child(slot)
		
		slot.custom_minimum_size = Vector2(
			grid_container.size.x / columns,
			grid_container.size.x / columns
		)

	hide_inventory()
	# Restore items if called early
	if _pending_restore_data.size() > 0:
		restore_inventory_items(_pending_restore_data[0], _pending_restore_data[1])
		_pending_restore_data.clear()

func add_item(item: Item) -> void:
	for slot in inventory_slots:
		if slot.is_empty():
			slot.add_item(item)
			return

func _on_button_pressed() -> void:
	if opened:
		hide_inventory()
	else:
		show_inventory()

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
			#items.push_back(slot.StoredItem.item_name)
	#return items

func get_inventory_items_name() -> Array[String]:
	var items_name: Array[String] = []
	for slot in inventory_slots:
		if slot.stored_item != null:
			items_name.append(slot.stored_item.item_name)
	return items_name
	
func restore_inventory_items(item_dictionary: Dictionary, items_list: Array) -> void:
	if not _restore_ready:
		_pending_restore_data = [item_dictionary, items_list]
		return
	
	var inventory_items: Array[Item] = []
	for item in items_list:
		if item_dictionary.has(item):
			inventory_items.append(item_dictionary[item])
		else:
			push_error("Missing object for id: %s" % item)
	
	for item in inventory_items:
		self.add_item(item)

func has(item: Item) -> bool:
	for slot in inventory_slots:
		if slot.stored_item == item:
			return true
	return false
