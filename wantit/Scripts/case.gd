extends Resource
class_name Case

## may not be changed after save files where slug exists, case_slug = case_id
@export var case_slug: String
@export var case_title: String
@export var case_topic: String
@export var case_location_scenes: Array[PackedScene]
var case_locations: Array[Location]
var inventory_scene: PackedScene = load("res://Scenes/inventory.tscn")
var inventory: Inventory
var interactions: Array
var is_completed: bool = false
var restored_inventory_items: Array
@export var events: Array[Event]
var from_location: String

signal location_switch_requested(location_name: String)
signal location_switch_requested_from_event(location_name: String)
signal case_overview_opened(location: Location)
signal case_selected(case_title: String)
signal item_found(item: Item)

func instantiate(saved_case_data: Dictionary): 
	case_locations.clear()
	restore_case_data(saved_case_data)
	
	for scene in case_location_scenes:
		var instance := scene.instantiate()
		if instance is Location:
			setup_location(instance, saved_case_data)
		else:
			push_error("Scene does not instantiate to a Location: " + scene.resource_path)
	
	var case_collectible_items = get_case_collectible_items()
	inventory = inventory_scene.instantiate() as Inventory
	inventory.restore_inventory_items(case_collectible_items, restored_inventory_items)
	
	GlobalTimer.start_timer(case_slug)

func setup_location(location_instance: Location, saved_case_data: Dictionary):
	var location := location_instance as Location
	var saved_location_data = saved_case_data.get(location.location_name, {})
	location.initialize(saved_location_data, self)
	_setup_location_connections(location)
	case_locations.append(location)

func _setup_location_connections(location: Location) -> void:
	if location.has_signal("item_found"):
		location.connect("item_found", _on_item_found)
	if location.has_signal("location_switch_requested"):
		location.connect("location_switch_requested", _on_location_switch_requested)
	if location.has_signal("case_overview_opened"):
		location.connect("case_overview_opened", _on_case_overview_opened)
	if location.has_signal("case_selected"):
		location.connect("case_selected", _on_case_selected)

func _on_item_found(_item: Item, _location: Location = null) -> void:
	handle_item_found(_item, _location)
	
func handle_item_found(_item: Item, _location: Location = null) -> void:
	if not inventory.has(_item):
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
		if trigger.is_valid(player_items) and trigger.has_started == false:
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
	
func _on_location_switch_requested(_target_location_name: String, _source_location_name: String):
	location_switch_requested.emit(_target_location_name)
	from_location = _source_location_name

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
	
func reset_case_progress() -> void:
	interactions.clear()
	inventory.inventory_slots.clear()
	restored_inventory_items.clear()
	
	for location in case_locations:
		location.reset_progress()

	for event in events:
		event.has_started = false
	print("Cleared current case data.")

func restore_case_data(save_data: Dictionary):
	if not save_data.is_empty():
		restored_inventory_items = save_data.get("inventory_items_names", [])
		interactions = save_data.get("interactions_history", [])

func get_save_data() -> Dictionary:
	var save_data := {}
	save_data["inventory_items"] = inventory.get_inventory_items_name()
	save_data["interactions_history"] = interactions
	
	for location in case_locations:
		save_data[location.location_name] = location.serialize()
	
	return save_data
