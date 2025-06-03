extends Resource

class_name Case

## may not be changed after save files where slug exists, case_slug = case_id
@export var case_slug: String
@export var case_title: String
@export var case_location_scenes: Array[PackedScene]
var case_locations: Array[Location]
# @export var closing_scene: PackedScene
@export var inventory_scene: PackedScene
var inventory: Inventory
var interactions: Array
var is_completed: bool
var restored_inventory_items: Array

signal on_location_switch_requested(location_name: String)

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

func _on_non_collectable_clue_found(clue_name: String, location: Location) -> void:
	interactions.append(clue_name)
	var player_items = get_player_items()
	#location.update_hint_text(player_items)
	location.call_deferred("update_hint_text", player_items)
	print("Non-collectable clue: %s is added to a list of interactions." %clue_name)

func open_room(path):
	var room = load(path)
	room.case = self

#func is_completed():
	#pass
	
func _on_location_switch_requested(location_name: String):
	emit_signal("on_location_switch_requested", location_name)
	
func are_all_clues_found(): #Do we need it??
	for location in case_locations:
		if not location.are_all_clues_found():
			return false
	return true

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
