extends Node
class_name Location

@export var location_name: String
var case: Case
@export var items: Array[Item] = []
@export var has_inventory: bool
var inventory: Inventory
var dialogue: DialogueComponent
var helpsystem: Helpsystem

signal item_found(item: Item, location: Location)
signal location_switch_requested(location_name: String)

func _ready():
	await get_tree().process_frame
	print("Setting up location: %s." % location_name)
	call_deferred("_setup_connections")
	dialogue = get_node_or_null("DialogueComponent")
	helpsystem = get_node_or_null("Helpsystem")
	call_deferred("setup_components", case)
	update_items_visibility()
	if dialogue:
		dialogue.start_dialogue()

func set_inventory(case_inventory: Inventory) -> void:
	if not has_inventory:
		return
	
	inventory = case_inventory
	
	if inventory.get_parent():
		inventory.get_parent().remove_child(inventory)
		
	if not inventory.is_inside_tree():
		add_child(inventory)

func _setup_connections():
	var items = get_tree().get_nodes_in_group("location_items")
	for item in items:
		item.connect("item_found", _on_item_found)
	
	var buttons = get_tree().get_nodes_in_group("location_switch_buttons")
	for button in buttons:
		button.connect("location_switch_requested", _on_location_switch_requested)

func _on_item_found(item: Item) -> void:
	if item.is_collectable:
		disable_item(item) 
	item_found.emit(item, self)

func _on_location_switch_requested(requested_location_name: String):
	location_switch_requested.emit(requested_location_name)

func update_items_visibility():
	for item in items:
		if case.inventory.has(item) or case.interactions.has(item):
			item.mark_found()
			disable_item(item)

func disable_item(item):
	item.disabled = true
	if item.is_collectable:
		item.hide()

func get_item_by_name(item_name: String) -> Item:
	for item in items:
		if item.item_name == item_name:
			return item
	#FIXME add handle no item found
	return null

func setup_components(inventory_provider):
	if dialogue:
		dialogue.inventory_provider = inventory_provider
	
	if helpsystem:
		helpsystem.inventory_provider = inventory_provider
	
	for item in items:
		var item_dialogue_component = item.get_node_or_null("DialogueComponent")
		if item_dialogue_component:
			item_dialogue_component.inventory_provider = inventory_provider
