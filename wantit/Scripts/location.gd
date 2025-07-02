extends Node
class_name Location

@export var location_name: String
var case: Case
@export var items: Array[Item] = []
@export var hints: Array[Hint]
@export var has_inventory: bool
@export var location_dialogue: Dialogue
var inventory: Inventory
var dialogue_player: DialoguePlayer
var helpsystem: Helpsystem

signal item_found(item: Item, location: Location)
signal location_switch_requested(location_name: String)

func _ready():
	set_item_dialogues()
	if dialogue_player:
		dialogue_player.activate()
	
	if not hints.is_empty():
		helpsystem = get_node_or_null("Helpsystem")
		if helpsystem:
			helpsystem.inventory_provider = case
			helpsystem.set_hints(hints)
		else:
			push_warning("Helpsystem node not found in Location: %s" % location_name)
	
	call_deferred("_setup_connections")
	update_items_visibility()
	
func setup_dialogue_player(_location_dialogue: Dialogue, _inventory_provider: Resource, _data: Array) -> void:
	dialogue_player = DialoguePlayer.new(_location_dialogue, _inventory_provider, _data)

func set_inventory(case_inventory: Inventory) -> void:
	if not has_inventory:
		return
	inventory = case_inventory
	if inventory.get_parent():
		inventory.get_parent().remove_child(inventory)
	if not inventory.is_inside_tree():
		add_child(inventory)

func _setup_connections() -> void:
	var _items = get_tree().get_nodes_in_group("location_items")
	for item in _items:
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

func get_item_by_name(_item_name: String) -> Item:
	for item in items:
		if item.item_name == _item_name:
			return item
	push_error("Item not found in location '%s': %s" % [location_name, _item_name])
	return null

func set_item_dialogues() -> void:
	for item in items:
		if item.item_dialogue:
			item.add_dialogue_player(item.item_dialogue, case, [])


func _on_documents_on_table_item_found(item: Item) -> void:
	pass # Replace with function body.
