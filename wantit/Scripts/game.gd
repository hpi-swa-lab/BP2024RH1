extends Node 

class_name Game

var active_case_slug: String = ""
var current_location: Location
var current_location_name: String = ""
@export var cases: Array[Case]
var gamesaver = GameSaver.new()
var inventory_items_names: Array

func _ready():
	get_tree().auto_accept_quit = false
	gamesaver.load_game(self)
	
	if active_case_slug == "":
		active_case_slug = cases[0].case_slug
	var active_case = get_case_by_slug(active_case_slug)
	start_case(active_case)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		gamesaver.save_game(self)
		get_tree().quit()

func get_case_by_slug(case_slug: String) -> Case:
	for case in cases:
		if case.case_slug == case_slug:
			return case
	push_error("Case not found")
	return null

func get_active_case():
	return get_case_by_slug(active_case_slug)

func start_case(case: Case) -> void:
	case.restored_inventory_items = inventory_items_names
	case.instantiate()
	
	var location_index = 0
	if current_location_name != "":
		location_index = case.get_location_index_by_name(current_location_name)
	switch_location(case.case_locations[location_index])

#func _on_case_completed():
	#start_case(cases[cases.find_custom(func (case): return not case.is_completed)])
	##FIXME add error handling when null returned

func get_completed_cases() -> Array:
	var completed_cases = []
	for case in cases:
		if case.is_completed:
			completed_cases.append(case)
	return completed_cases
		
func switch_location(location: Location):
	if current_location:
		current_location.get_parent().remove_child(current_location)
	var case = get_active_case()
	location.set_inventory(case.inventory)
	
	var player_items = case.get_player_items()
	#if player_items:
	location.update_hint_text(player_items)
	
	current_location = location
	current_location.location_switch_requested.connect(func(name):
		var index = case.case_locations.find_custom( func (_location):
			return _location.location_name == name)
		assert(index >= 0)
		var _location = case.case_locations[index]
		switch_location(_location))
	add_child(current_location)

func _on_location_switch_requested(location_name):
	var current_case = get_case_by_slug(active_case_slug)
	current_case.get_location_by_name(location_name)
	switch_location(current_case.get_location_by_name(location_name))

func set_completed_cases():
	pass

func get_case_inventory() -> Array[String]:
	var active_case = get_active_case()
	return active_case.inventory.get_inventory_items_name()
