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
var is_completed: bool
var restored_inventory_items: Array
@export var minigame_triggers: Array[MinigameTrigger]


signal on_location_switch_requested(location_name: String)
signal minigame_location_switch_requested(location_name: String)

func instantiate():
	connect("on_location_switch_requested", _on_location_switch_requested)
	
	case_locations.clear()
	for scene in case_location_scenes:
		var instance := scene.instantiate()
		if instance is Location:
			var location := instance as Location
			location.case = self
			location.connect("non_collectable_clue_found", _on_non_collectable_clue_found)
			location.connect("collectable_clue_found", _on_collectable_clue_found)
			case_locations.append(location)
		else:
			push_error("Scene does not instantiate to a Location: " + scene.resource_path)
	
	inventory = inventory_scene.instantiate() as Inventory
	var clue_dictionary = create_clue_dictionary()
	print("Items names restored in a case: %s" %[restored_inventory_items])
	inventory.restore_inventory_items(clue_dictionary, restored_inventory_items)
	var inventory_items = inventory.get_inventory_items_name()

func _on_collectable_clue_found(clue: Clue, location: Location) -> void:
	inventory.add_item(clue)
	var player_items = get_player_items()
	location.update_hint_text(player_items)
	print("Item: %s added to inventory" %clue.clue_name) 
	print("Updated player items: %s" %[player_items])
	var minigame_location = check_matching_minigame(player_items)
	print("Minigame location available: %s" %[minigame_location])
	if minigame_location:
		print("Starting minigame")
		start_minigame(minigame_location)

func _on_non_collectable_clue_found(clue_name: String, location: Location) -> void:
	interactions.append(clue_name)
	var player_items = get_player_items()
	#location.update_hint_text(player_items)
	location.call_deferred("update_hint_text", player_items)
	print("Non-collectable clue: %s is added to a list of interactions." %clue_name)
	print("Updated player items: %s" %[player_items])
	var minigame_location = check_matching_minigame(player_items)
	print("Minigame location available: %s" %[minigame_location])
	if minigame_location:
		print("Starting minigame")
		start_minigame(minigame_location)
	
func check_matching_minigame(player_items: Array):
	for trigger in minigame_triggers:
		if not trigger.is_started and is_subset(trigger.conditions, player_items):
			trigger.is_started = true
			return trigger.location_name
	return null

func is_subset(subset: Array, superset: Array) -> bool:
	for item in subset:
		if not superset.has(item):
			return false
	return true

func start_minigame(location_name: String):
	emit_signal("minigame_location_switch_requested", location_name)
	
#func open_room(path):
	#var room = load(path)
	#room.case = self

#func is_completed():
	#pass
	
func _on_location_switch_requested(location_name: String):
	emit_signal("on_location_switch_requested", location_name)

func get_location_by_name(location_name: String) -> Location:
	for location in case_locations:
		print(location.location_name)
		if location.location_name == location_name:
			return location
	#FIXME handle no location found
		else:
			print(location_name, "dat suchen wir")
	return null

func get_location_index_by_name(target_name: String):
	for i in case_locations.size():
		if case_locations[i].location_name == target_name:
			return i
	return null	

#for mapping clue_name(s) after reloading the game
func create_clue_dictionary() -> Dictionary:
	var result = {}
	for location in case_locations:
		for clue in location.clues:
			result[clue.clue_name] = clue
	return result

func get_player_items() -> Array:
	var player_items = []
	player_items.append_array(inventory.get_inventory_items_name())
	player_items.append_array(interactions)
	return player_items
