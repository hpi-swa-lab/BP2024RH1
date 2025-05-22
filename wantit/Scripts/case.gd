extends Resource

class_name Case

## may not be changed after save files where slug exists, case_slug = case_id
@export var case_slug: String
@export var case_title: String
@export var case_location_scenes: Array[PackedScene]
var case_locations: Array[Location]
@export var closing_scene: PackedScene
var inventory: Inventory
var interactions: Array
var is_completed: bool
#@onready var location = $location

signal on_location_switch_requested(location_name: String)

func instantiate():
	case_locations = case_location_scenes.map(func(scene): return scene.instantiate())

func _ready():
	#connect("all_location_clues_found", Callable(self, "_on_all_location_clues_found"))
	connect("collectable_clue_found", Callable(self, "_on_collectable_clue_found"))
	connect("non_collectable_clue_found", Callable(self, "_on_non_collectable_clue_found"))
	connect("on_location_switch_requested", Callable(self, "_on_location_switch_requested"))

#func _on_all_location_clues_found(location_id: String):
	#print("All clues found in location: {}".format(location_id))
	#if case_data.are_all_clues_found():
		#emit_signal("all_case_clues_found", case_data.closing_scene) 
		##this signal should be catched by a game and trigger scene switching
		
func _on_collectable_clue_found(clue: Clue) -> void:
	inventory.add_clue(clue)

func _on_non_collectable_clue_found(clue:Clue) -> void:
	interactions.append(clue)

func open_room(path):
	var room = load(path)
	room.case = self

#func is_completed():
	#pass
	
func add_to_inventory(item_id: String):
	pass
	
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
