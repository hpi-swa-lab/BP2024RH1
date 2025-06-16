extends Node 

class_name Game

var active_case_slug: String = ""
var current_location: Location
var current_location_name: String = ""
@export var cases: Array[Case]
var gamesaver = GameSaver.new()
var inventory_items_names: Array
var interactions_history: Array
var restored_game_data
var played_dialogues: Dictionary

func _ready():
	get_tree().auto_accept_quit = false
	gamesaver.load_saved_game_data(self)
	if restored_game_data:
		load_game_data()
	start_current_case()

func start_current_case():
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
	case.interactions = interactions_history
	#if played_dialogues
	case.restored_played_dialogues = played_dialogues
	
	case.instantiate()
	set_connections(case)

	var location_index = 0
	if current_location_name != "":
		location_index = case.get_location_index_by_name(current_location_name)
	switch_location(case.case_locations[location_index])

func set_connections(case: Case):
	case.connect("event_location_switch_requested", _on_location_switch_requested)
	case.connect("on_location_switch_requested", _on_location_switch_requested)
	case.connect("case_overview_opened", _on_case_overview_opened)
	case.connect("on_case_selected", _on_start_new_case)

func complete_case() -> void:
	var current_case = get_case_by_slug(active_case_slug)
	current_case.is_completed = true
	current_case.clear_case_data()
	gamesaver.save_game(self)
	setup_default_case()
	start_current_case() #name of the function is absolutely not perfect here

func setup_default_case() -> void:
	active_case_slug = "default"
	current_location_name = ""
	#played_dialogues["default_office"] = "default"
	#TODO add some text to motivate user to open another case

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
		
	#if location.has_inventory:
	location.set_inventory(case.inventory)
	
	var player_items = case.get_player_items()
	#location.update_hint_text(player_items)
	location.call_deferred("update_hint_text", player_items)
	location.call_deferred("start_dialogue")
	
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
	var location = current_case.get_location_by_name(location_name)
	switch_location(location)

func set_completed_cases():
	pass

func get_case_inventory() -> Array[String]:
	var active_case = get_active_case()
	return active_case.inventory.get_inventory_items_name()

func get_case_interactions() -> Array:
	var active_case = get_active_case()
	return active_case.interactions

func load_game_data():
	active_case_slug = restored_game_data.get("active_case_slug", "")
	current_location_name = restored_game_data.get("current_location_name")
	inventory_items_names = restored_game_data.get("inventory_items", [])
	interactions_history = restored_game_data.get("interactions", [])
	played_dialogues = restored_game_data.get("dialogues", {})
	#completed_cases = restored_game_data.get("completed_cases", [])

#enable adding interaction from dialogue
func interaction_happened(interaction_name: String) -> void:
	var current_case = get_case_by_slug(active_case_slug)
	var interaction_item = Item.new()
	interaction_item.item_name = interaction_name
	interaction_item.is_collectable = false
	current_case._on_item_found(interaction_item)

func _on_case_overview_opened(location: Location) -> void:
	var active_case = get_active_case()
	var location_index = active_case.get_location_index_by_name(location.location_name)
	var cases_titles = get_cases_titles()
	active_case.case_locations[location_index].add_cases(cases_titles)

func get_cases_titles() -> Array:
	var case_titles = []
	for case in cases.slice(1):
		case_titles.append(case.case_title)
	return case_titles

func _on_start_new_case(case_title: String):
	var requested_case_slug = get_case_slug_by_title(case_title)
	active_case_slug = requested_case_slug
	current_location_name = ""
	start_current_case()

func get_case_slug_by_title(target_title: String):
	for case in cases:
		if case.case_title == target_title:
			return case.case_slug
	return null

func get_played_dialogues() -> Dictionary:
	var played_dialogues := {}
	var opened_case = get_case_by_slug(active_case_slug)

	for location in opened_case.case_locations:
		if location.dialogue!= null:
			for condition in location.dialogue.conditions:
				if condition.is_started:
					played_dialogues[location.location_name] = condition.dialogue_start
	return played_dialogues
