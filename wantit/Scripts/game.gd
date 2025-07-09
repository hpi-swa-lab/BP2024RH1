extends Node 
class_name Game

var active_case_slug: String = ""
var current_location: Location
var current_location_name: String = ""
@export var cases: Array[Case]
var gamesaver = GameSaver.new()
var saved_game_data
var saved_case_data: Dictionary
var completed_cases: Array


func _ready():
	get_tree().auto_accept_quit = false
	gamesaver.load_saved_game_data(self)
	
	if saved_game_data:
		restore_saved_game()
	else:
		start_new_game()

func restore_saved_game():
	load_game_data()
	var active_case = get_case_by_slug(active_case_slug)
	start_case(active_case, saved_case_data)

func start_new_game():
	active_case_slug = cases[0].case_slug
	var active_case = get_case_by_slug(active_case_slug)
	start_case(active_case)

func start_case(_case: Case, _case_data: Dictionary = {}):
	_case.instantiate(_case_data)
	setup_case_connections(_case)
	switch_to_restored_or_default_location(_case)

func switch_to_restored_or_default_location(case: Case):
	var location_index := 0
	if current_location_name != "":
		if case.get_location_index_by_name(current_location_name) != null:
			location_index = case.get_location_index_by_name(current_location_name)
	switch_location(case.case_locations[location_index])

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

func setup_case_connections(case: Case):
	case.connect("location_switch_requested_from_event", _on_location_switch_requested)
	case.connect("location_switch_requested", _on_location_switch_requested)
	case.connect("case_overview_opened", _on_case_overview_opened)
	case.connect("case_selected", _on_start_case)
	case.item_found.connect(save_current_progress)

func complete_case() -> void:
	mark_case_completed()
	save_current_progress(null)
	reset_to_default_case()
	start_new_case()

func mark_case_completed() -> void:
	var current_case = get_case_by_slug(active_case_slug)
	current_case.is_completed = true
	completed_cases.append(current_case.case_slug)
	current_case.clear_case_data()
	
	GlobalTimer.end_timer(current_case.case_slug)
	Analytics.export_analytics(current_case.case_slug, GlobalTimer.get_time(current_case.case_slug))

func reset_to_default_case() -> void:
	active_case_slug = "default"
	current_location_name = ""
	#played_dialogues["default_office"] = "default"
	#TODO add some text to motivate user to open another case

func start_new_case() -> void:
	var default_case = get_case_by_slug(active_case_slug)
	start_case(default_case)

func save_current_progress(_item: Item) -> void:
	gamesaver.save_game(self)

func switch_location(location: Location):
	if current_location:
		GlobalTimer.end_timer(current_location.location_name)
		current_location.export_location_analytics()
		print("exporting scene analytics", current_location.location_name, GlobalTimer.get_time(current_location.location_name))
		current_location.get_parent().remove_child(current_location)
	var case = get_active_case()
		
	if location.has_inventory:
		location.set_inventory(case.inventory)
	if location.dialogue_player:
		location.dialogue_player.start_dialogue()
	
	current_location = location
	add_child(current_location)
	GlobalTimer.start_timer(current_location.location_name)
	save_current_progress(null)

func _on_location_switch_requested(location_name):
	var current_case = get_case_by_slug(active_case_slug)
	var location = current_case.get_location_by_name(location_name)
	print(active_case_slug)
	print(location_name)
	switch_location(location)

func get_case_inventory() -> Array[String]:
	var active_case = get_active_case()
	return active_case.inventory.get_inventory_items_name()

func get_case_interactions() -> Array:
	var active_case = get_active_case()
	return active_case.interactions

func load_game_data():
	active_case_slug = saved_game_data.get("active_case_slug", "")
	current_location_name = saved_game_data.get("current_location_name")
	completed_cases = saved_game_data.get("completed_cases", [])
	for case in cases:
		if case.case_slug in completed_cases:
			case.is_completed = true
	
	saved_case_data["inventory_items_names"] = saved_game_data.get("inventory_items", [])
	saved_case_data["interactions_history"] = saved_game_data.get("interactions", [])
	saved_case_data["played_dialogues"] = saved_game_data.get("location_dialogues", {})

#enables adding interaction from dialogue
func interaction_happened(interaction_name: String) -> void:
	var current_case = get_case_by_slug(active_case_slug)
	var interaction_item = Item.new()
	interaction_item.item_name = interaction_name
	interaction_item.is_collectable = false
	current_case._on_item_found(interaction_item)

func _on_case_overview_opened(location: Location) -> void:
	var active_case = get_active_case()
	var location_index = active_case.get_location_index_by_name(location.location_name)
	var cases_states = get_cases_states()
	active_case.case_locations[location_index].add_cases(cases_states)

func get_cases_states() -> Dictionary:
	var cases_states = {}
	for case in cases.slice(1):
		cases_states[case.case_title] = [case.is_completed, case.case_topic]
	return cases_states

func _on_start_case(_case_title: String):
	var case_slug = get_case_slug_by_title(_case_title)
	active_case_slug = case_slug
	var requested_case = get_case_by_slug(case_slug)
	start_case(requested_case)

func get_case_slug_by_title(target_title: String):
	for case in cases:
		if case.case_title == target_title:
			return case.case_slug
	return null

func get_played_location_dialogues() -> Dictionary:
	var played_dialogues := {}
	var active_case = get_case_by_slug(active_case_slug)
#
	for location in active_case.case_locations:
		if location.dialogue_player!= null:	
			played_dialogues[location.location_name] = location.dialogue_player.get_played_dialogues()
	return played_dialogues

func get_save_data() -> Dictionary:
	var save_data = {}
	save_data["active_case_slug"] = active_case_slug
	save_data["current_location_name"] = current_location.location_name
	save_data["inventory_items"] = get_case_inventory()
	save_data["interactions"] = get_case_interactions()
	save_data["location_dialogues"] = get_played_location_dialogues()
	save_data["completed_cases"] = completed_cases
	return save_data
