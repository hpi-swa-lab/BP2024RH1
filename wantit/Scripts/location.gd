extends Node

class_name Location

@export var location_name: String
var case: Case
@export var clues: Array[Clue] = []
@export var hints: Array[Hint] = []
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String
var hint_text: String = "Default text"
var inventory: Inventory

signal collectable_clue_found(clue: Clue)
signal non_collectable_clue_found(clue: Clue)
signal location_switch_requested(location_name: String)

func _ready():
	await get_tree().process_frame
	print("Setting up location: %s." % location_name)
	call_deferred("_setup_connections")
	#update_items_visibility()
	
	#DialogueManager.show_dialogue_balloon_scene(
			#"res://dialogue_balloons/monologue/balloon_monologue.tscn",
			#dialogue_resource,
			#dialogue_start)
	#await DialogueManager.dialogue_ended

func set_inventory(case_inventory: Inventory) -> void:
	inventory = case_inventory
	
	if inventory.get_parent():
		inventory.get_parent().remove_child(inventory)
		
	if not inventory.is_inside_tree():
		add_child(inventory)

func _setup_connections():
	var clues = get_tree().get_nodes_in_group("location_clues")
	for clue in clues:
		clue.connect("clue_found", 
						_on_clue_found)
	
	var buttons = get_tree().get_nodes_in_group("location_switch_buttons")
	for button in buttons:
		button.connect("location_switch_requested", 
						_on_location_switch_requested)

func _on_clue_found(clue: Clue) -> void:
	print("Clue: %s found in location: %s" % [clue.clue_name, self.location_name])
	if clue.is_collectable:
		emit_signal("collectable_clue_found", clue)
		disable_item(clue) 
	else:
		emit_signal("non_collectable_clue_found", clue.clue_name)
	#TODO update hint text
	
func _on_location_switch_requested(requested_location_name: String):
	emit_signal("location_switch_requested", requested_location_name)

func get_available_hints(player_items: Array[String]) -> Array[String]:
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

#TODO add dialogues

func update_hint_text(inventory_items):
	var valid_hints = get_available_hints(inventory_items)
	#print(valid_hints)
	#FIXME choose one hint when several available
	if valid_hints:
		hint_text = valid_hints[0]
