extends Resource

class_name Case

## may not be changed after save files where slug exists, case_slug = case_id
@export var case_slug: String
@export var case_title: String
@export var case_location_scenes: Array[PackedScene]
var case_locations: Array[Location]
# @export var closing_scene: PackedScene
var inventory: Inventory
var interactions: Array
var is_completed: bool

signal on_location_switch_requested(location_name: String)
#
#func instantiate():
	##case_locations = case_location_scenes.map(func(scene): return scene.instantiate())
	#case_locations = case_location_scenes.map(func(scene: PackedScene) -> Location:
		#var location = scene.instantiate() as Location
		#return location
	#)

func instantiate():
	connect("on_location_switch_requested", _on_location_switch_requested)
	
	case_locations.clear()  # Optional, if already populated
	for scene in case_location_scenes:
		var instance := scene.instantiate()
		if instance is Location:
			var location := instance as Location
			location.connect("non_collectable_clue_found", _on_non_collectable_clue_found)
			location.connect("collectable_clue_found", _on_collectable_clue_found)
			location.connect("inventory_items_requested", _on_inventory_items_requested)
			case_locations.append(location)
		else:
			push_error("Scene does not instantiate to a Location: " + scene.resource_path)

func _on_collectable_clue_found(clue: Clue) -> void:
	#inventory.add_item(clue)
	print("Item: %s added to inventory" %clue.clue_name)	

func _on_non_collectable_clue_found(clue_name: String) -> void:
	interactions.append(clue_name)
	print("Non-collectable clue: %s is added to interactions history." %clue_name)
	#print(interactions)

func open_room(path):
	var room = load(path)
	room.case = self

#func is_completed():
	#pass
	
#func add_to_inventory(item_id: String):
	#pass
	
func _on_location_switch_requested(location_name: String):
	emit_signal("on_location_switch_requested", location_name)
	
func are_all_clues_found():
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

func _on_inventory_items_requested(location: Location):
	var item_names = inventory.get_inventory_items_name()
	location.set_inventory_items(item_names)
	location.update_hint_text()

func get_location_index_by_name(target_name: String):
	for i in case_locations.size():
		if case_locations[i].location_name == target_name:
			return i
	return null	
