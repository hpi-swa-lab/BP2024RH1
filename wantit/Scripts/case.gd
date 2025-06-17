extends Resource
class_name Case

## may not be changed after save files where slug exists, case_slug = case_id
@export var case_slug: String
@export var case_title: String
@export var case_location_scenes: Array[PackedScene]
var case_locations: Array[Location]
@export var inventory_scene: PackedScene
var inventory: Inventory
var interactions: Array
var is_completed: bool = false
var restored_inventory_items: Array
@export var event_triggers: Array[EventTrigger]
var restored_played_dialogues: Dictionary


signal on_location_switch_requested(location_name: String)
signal event_location_switch_requested(location_name: String)
signal case_overview_opened(location: Location)
signal on_case_selected(case_title: String)
signal item_found(item: Item)

func instantiate():
	connect("on_location_switch_requested", _on_location_switch_requested)
	
	case_locations.clear()
	for scene in case_location_scenes:
		var instance := scene.instantiate()
		if instance is Location:
			var location := instance as Location
			location.case = self
			location.call_deferred("setup_components", self)
			
			#var location_dialogue_component = instance.get_node_or_null("DialogueComponent")
			#if location_dialogue_component:
					#location_dialogue_component.inventory_provider = self
			#
			#
			#for item in location.items:
				#var item_dialogue_component = item.get_node_or_null("DialogueComponent")
				#if item_dialogue_component:
					#item_dialogue_component.inventory_provider = self
			
			#`FIXME
			#if restored_played_dialogues.has(location.location_name):
				#var dialogue_start = restored_played_dialogues[location.location_name]
				#var index = location.dialogue.get_condition_index_by_dialogue_start(dialogue_start)
				#if index != null:
					#location.dialogue.conditions[index].is_started = true
			
			location.connect("item_found", _on_item_found)
			if location.has_signal("case_overview_opened"):
				location.connect("case_overview_opened", _on_case_overview_opened)
			if location.has_signal("case_selected"):
				location.connect("case_selected", _on_case_selected)
			case_locations.append(location)
		else:
			push_error("Scene does not instantiate to a Location: " + scene.resource_path)
	
	inventory = inventory_scene.instantiate() as Inventory
	var item_dictionary = create_item_dictionary()
	print("Items restored in a case: %s" %[restored_inventory_items])
	inventory.restore_inventory_items(item_dictionary, restored_inventory_items)
	var inventory_items = inventory.get_inventory_items_name()

func _on_item_found(item: Item, location: Location = null) -> void:
	if item.is_collectable:
		inventory.add_item(item)
	else:
		interactions.append(item.item_name)
	var player_items = get_player_items()
	if location != null:
		location.update_hint_text(player_items)
	#print("Item: %s added to player items." %item.item_name) 
	print("Updated player items: %s" %[player_items])
	item_found.emit(item)
	start_event(player_items)

func start_event(player_items: Array):
	var event_location = check_matching_event(player_items)
	print("Event location available: %s" %[event_location])
	if event_location:
		print("Starting event")
		_on_start_event(event_location)
	
func check_matching_event(player_items: Array):
	var best_match = null
	for trigger in event_triggers:
		#if not trigger.is_started and is_subset(trigger.conditions, player_items):
		if is_subset(trigger.conditions, player_items):
			if best_match == null or best_match.conditions.size() < trigger.conditions.size():
				best_match = trigger
			#trigger.is_started = true
	
	if best_match != null:
		return best_match.location_name
		#return trigger.location_name
		print("Event: %s is available" %[best_match.event_name])
	else:
		return null

func is_subset(subset: Array, superset: Array) -> bool:
	for item in subset:
		if not superset.has(item):
			return false
	return true

func _on_start_event(location_name: String):
	emit_signal("event_location_switch_requested", location_name)
	
func _on_location_switch_requested(location_name: String):
	emit_signal("on_location_switch_requested", location_name)

func get_location_by_name(location_name: String) -> Location:
	for location in case_locations:
		if location.location_name == location_name:
			return location
	#FIXME handle no location found
	return null

func get_location_index_by_name(target_name: String):
	for i in case_locations.size():
		if case_locations[i].location_name == target_name:
			return i
	return null	

#for mapping item_name(s) after reloading the game
func create_item_dictionary() -> Dictionary:
	var result = {}
	for location in case_locations:
		for item in location.items:
			result[item.item_name] = item
	return result

func get_player_items() -> Array:
	var player_items = []
	player_items.append_array(inventory.get_inventory_items_name())
	player_items.append_array(interactions)
	return player_items

func _on_case_overview_opened(location: Location):
	case_overview_opened.emit(location)

func _on_case_selected(case_title: String):
	on_case_selected.emit(case_title)
	
func clear_case_data() -> void:
	interactions.clear()
	inventory.inventory_slots.clear()
	restored_inventory_items.clear()
	restored_played_dialogues.clear()
	
	for location in case_locations:
		if location.dialogue:
			for condition in location.dialogue.conditions:
				condition.is_started = false
	print("Cleared current case data.")
	var player_items = get_player_items()
	print(player_items)
