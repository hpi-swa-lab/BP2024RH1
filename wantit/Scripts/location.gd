extends Node

class_name Location

@export var location_name: String
var case: Case
@export var clues: Array[Clue] = []
@export var hints: Array[Hint] = []
#@export var dialogue_resource: DialogueResource
@export var dialogue: Dialogue
var hint_text: String = "Default text"
var inventory: Inventory

signal collectable_clue_found(clue: Clue, location: Location)
signal non_collectable_clue_found(clue: Clue, location: Location)
signal location_switch_requested(location_name: String)

func _ready():
	await get_tree().process_frame
	print("Setting up location: %s." % location_name)
	call_deferred("_setup_connections")
	update_items_visibility()
	if dialogue != null and not dialogue.is_started:
		if dialogue.has_condition():
			#emit_signal("inventory_state_requested")
			pass
		else:
			start_dialogue(dialogue)

func set_inventory(case_inventory: Inventory) -> void:
	inventory = case_inventory
	
	if inventory.get_parent():
		inventory.get_parent().remove_child(inventory)
		
	if not inventory.is_inside_tree():
		add_child(inventory)

func _setup_connections():
	#FIXME - DialogueManager can use the functions of the scene its called in 
	#DialogueManager.connect("location_switch_requested", _on_location_switch_requested)
	
	var clues = get_tree().get_nodes_in_group("location_clues")
	for clue in clues:
		clue.connect("clue_found", _on_clue_found)
	
	var buttons = get_tree().get_nodes_in_group("location_switch_buttons")
	for button in buttons:
		button.connect("location_switch_requested", _on_location_switch_requested)

func start_dialogue(dialogue: Dialogue, dialogue_start: String = "default"):
	DialogueManager.show_dialogue_balloon_scene(
		dialogue.baloon_type,
		dialogue.dialogue_resource,
		dialogue_start
	)
	dialogue.is_started = true

func _on_clue_found(clue: Clue) -> void:
	print("Clue: %s found in location: %s" % [clue.clue_name, self.location_name])
	if clue.is_collectable:
		emit_signal("collectable_clue_found", clue, self)
		disable_item(clue) 
	else:
		emit_signal("non_collectable_clue_found", clue.clue_name, self)
	
func _on_location_switch_requested(requested_location_name: String):
	emit_signal("location_switch_requested", requested_location_name)

func get_available_hints(player_items: Array) -> Array[String]:
	var results: Array[String] = []
	for hint in hints:
		if hint.is_valid(player_items):
			results.append(hint.hint_text)
	return results

func update_items_visibility():
	for item in clues:
		if case.inventory.has(item):
			disable_item(item)

func disable_item(item):
	item.disabled = true
	item.hide()

func get_clue_by_name(clue_name: String) -> Clue:
	for clue in clues:
		if clue.clue_name == clue_name:
			return clue
	#FIXME add handle no clue found
	return null

func update_hint_text(player_items):
	var valid_hints = get_available_hints(player_items)
	#FIXME choose one hint when several available
	if valid_hints:
		hint_text = valid_hints[0]
		if $Helpsystem:
			$Helpsystem.call_deferred("set_hint_text")
