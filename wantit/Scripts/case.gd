extends Resource
class_name Case

## may not be changed after save files where slug exists, case_slug = case_id
@export var case_slug: String
@export var case_title: String
@export var case_location_scenes: Array[PackedScene]
var case_locations: Array[Location]
var inventory_scene: PackedScene = load("res://Scenes/inventory.tscn")
var inventory: Inventory
var interactions: Array
var is_completed: bool = false
var restored_inventory_items: Array
@export var events: Array[Event]
var played_location_dialogues: Dictionary

signal location_switch_requested(location_name: String)
signal location_switch_requested_from_event(location_name: String)
signal case_overview_opened(location: Location)
signal case_selected(case_title: String)
signal item_found(item: Item)

func instantiate(_saved_case_data: Dictionary):
	case_locations.clear()
	restore_case_data(_saved_case_data)
	for scene in case_location_scenes:
		var instance := scene.instantiate()
		if instance is Location:
			_setup_location(instance)
		else:
			push_error("Scene does not instantiate to a Location: " + scene.resource_path)
	
	var case_collectible_items = get_case_collectible_items()
	inventory = inventory_scene.instantiate() as Inventory
	inventory.restore_inventory_items(case_collectible_items, restored_inventory_items)

func _setup_location(location_instance: Location):
	var location := location_instance as Location
	location.case = self
	if location.location_dialogue:
		var restored_location_data = get_restored_location_data(location)
		location.setup_dialogue_player(location.location_dialogue, self, restored_location_data)
	_setup_location_connections(location)
	case_locations.append(location)

func _setup_location_connections(location: Location) -> void:
	location.connect("item_found", _on_item_found)
	location.connect("location_switch_requested", _on_location_switch_requested)
	if location.has_signal("case_overview_opened"):
		location.connect("case_overview_opened", _on_case_overview_opened)
	if location.has_signal("case_selected"):
		location.connect("case_selected", _on_case_selected)

func _on_item_found(_item: Item, _location: Location = null) -> void:
	handle_item_found(_item, _location)
	
func handle_item_found(_item: Item, _location: Location = null) -> void:
	if _item.is_collectable:
		inventory.add_item(_item)
	else:
		interactions.append(_item.item_name)
	item_found.emit(_item)
	try_start_event()
	
func try_start_event() -> void:
	var available_event = check_matching_event()
	if available_event:
		start_event(available_event)
	
func check_matching_event():
	var player_items = get_player_items()
	for trigger in events:
		if trigger.is_valid(player_items):
			trigger.has_started = true
			return trigger.location_name
	return null

func is_subset(subset: Array, superset: Array) -> bool:
	for item in subset:
		if not superset.has(item):
			return false
	return true

func start_event(location_name: String):
	location_switch_requested_from_event.emit(location_name)
	
func _on_location_switch_requested(location_name: String):
	location_switch_requested.emit(location_name)

func get_location_by_name(location_name: String):
	for location in case_locations:
		if location.location_name == location_name:
			return location
	#FIXME handle no location found
	return null

func get_location_index_by_name(_target_name: String):
	for i in case_locations.size():
		if case_locations[i].location_name == _target_name:
			return i
	return null

func get_case_collectible_items() -> Dictionary:
	var collectible_items = {}
	for location in case_locations:
		for item in location.items:
			if item.is_collectable:
				collectible_items[item.item_name] = item 
	return collectible_items

func get_player_items() -> Array:
	var player_items = []
	player_items.append_array(inventory.get_inventory_items_name())
	player_items.append_array(interactions)
	return player_items

func _on_case_overview_opened(location: Location):
	case_overview_opened.emit(location)

func _on_case_selected(_case_title: String):
	case_selected.emit(_case_title)
	
func clear_case_data() -> void:
	interactions.clear()
	inventory.inventory_slots.clear()
	restored_inventory_items.clear()
	played_location_dialogues.clear()
	
	for location in case_locations:
		if location.dialogue_player:
			location.dialogue_player.reset_played_dialogues()
	print("Cleared current case data.")

func get_restored_location_data(location: Location):
	if played_location_dialogues.has(location.location_name):
		return played_location_dialogues[location.location_name]
	else:
		return []

func restore_case_data(_save_data: Dictionary):
	if not _save_data.is_empty():
		restored_inventory_items = _save_data["inventory_items_names"]
		interactions = _save_data["interactions_history"]
		played_location_dialogues = _save_data["played_dialogues"]
