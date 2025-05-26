extends Node 

class_name Game

var active_case_slug: String = ""
var gamesaver = GameSaver.new()
var current_location: Location
@export var cases: Array[Case]

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
	get_case_by_slug(active_case_slug)

func start_case(case: Case) -> void:
	case.instantiate()
	switch_location(case.case_locations[0])

func _on_case_completed():
	start_case(cases[cases.find_custom(func (case): return not case.is_completed)])
	#FIXME add error handling when null returned

func get_completed_cases() -> Array:
	var completed_cases = []
	for case in cases:
		if case.is_completed:
			completed_cases.append(case)
	return completed_cases
		
func switch_location(location: Location):
	if current_location:
		current_location.queue_free()
	var case = get_active_case()
	current_location = location
	current_location.location_switch_requested.connect(func(name):
		var index = case.case_locations.find_custom( func (_location):
			return _location.location_name == name)
		var _location = case.case_locations[index]
		switch_location(_location))
	add_child(current_location)

func _on_location_switch_requested(location_name):
	var current_case = get_case_by_slug(active_case_slug)
	current_case.get_location_by_name(location_name)
	switch_location(current_case.get_location_by_name(location_name))
