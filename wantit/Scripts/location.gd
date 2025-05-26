extends Node

class_name Location

@export var location_name: String
#@export var case_slug: String 
@export var location_path: String
@export var clues: Array[Clue] = []
@export var hints: Array[Hint] = []
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String
var active_hint_text: String = ""
var inventory_items: Array[String]

signal collectable_clue_found(clue: Clue)
signal non_collectable_clue_found(clue: Clue)
signal location_switch_requested(location_name: String)
signal inventory_items_requested(location: Location)

func _ready():
	await get_tree().process_frame
	print("Setting up location: %s." % location_name)
	call_deferred("_setup_connections")
	
	#TODO update hint text
	request_current_inventory()
	#DialogueManager.show_dialogue_balloon_scene(
			#"res://dialogue_balloons/monologue/balloon_monologue.tscn",
			#dialogue_resource,
			#dialogue_start)
	#await DialogueManager.dialogue_ended

func _setup_connections():
	var clue = get_node_or_null("Clue")
	if clue:
		clue.connect("clue_found", Callable(self, "_on_clue_found"))
	
	var buttons = get_tree().get_nodes_in_group("location_switch_buttons")
	for button in buttons:
		#print(button)
		button.connect("location_switch_requested", 
						Callable(self, "_on_location_switch_requsted"))


func _on_clue_found(clue: Clue) -> void:
	print("Clue: %s found in location: %s" % [clue.clue_name, self.location_name])
	if clue.is_collectable:
		emit_signal("collectable_clue_found", clue)
		disable_item(clue) 
	else:
		emit_signal("non_collectable_clue_found", clue.clue_name)
	
func _on_location_switch_requested(requested_location_name: String):
	emit_signal("location_switch_requested", requested_location_name)

func get_available_hints(player_items: Array[String]) -> Array[String]:
	var results: Array[String] = []
	for hint in hints:
		if hint.is_valid(player_items):
			results.append(hint.text)
	return results

func update_items_visibility():
	#for item in clues:
		#if case.interactions.has(item) or case.inventory.has(item):
			#disable_item(item)
			pass

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

func request_current_inventory() -> void:
	emit_signal("inventory_items_requested", self)

func update_hint_text():
	var valid_hints = get_available_hints(inventory_items)
	#FIXME choose one hint when several available
	active_hint_text = valid_hints[0]

func set_inventory_items(item_names: Array[String]) -> void:
	inventory_items = item_names.duplicate()
