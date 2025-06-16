extends Node

class_name Location

@export var location_name: String
var case: Case
@export var items: Array[Item] = []
@export var hints: Array[Hint] = []
@export var dialogue: Dialogue
@export var has_inventory: bool
var hint_text: String = "Default text"
var inventory: Inventory

signal item_found(item: Item, location: Location)
signal location_switch_requested(location_name: String)

func _ready():
	await get_tree().process_frame
	print("Setting up location: %s." % location_name)
	call_deferred("_setup_connections")
	update_items_visibility()
	if dialogue != null:
		start_dialogue()

func set_inventory(case_inventory: Inventory) -> void:
	if not has_inventory:
		return
	
	inventory = case_inventory
	
	if inventory.get_parent():
		inventory.get_parent().remove_child(inventory)
		
	if not inventory.is_inside_tree():
		add_child(inventory)

func _setup_connections():
	var items = get_tree().get_nodes_in_group("location_items")
	for item in items:
		item.connect("item_found", _on_item_found)
	
	var buttons = get_tree().get_nodes_in_group("location_switch_buttons")
	for button in buttons:
		button.connect("location_switch_requested", _on_location_switch_requested)

func start_dialogue():
	if dialogue != null:
		var player_items = case.get_player_items()
		var dialogue_condition = dialogue.choose_dialogue_by_requierements(player_items)
		if dialogue_condition != null:
			var index = dialogue.get_condition_index_by_dialogue_start(dialogue_condition)
			if index != null and not dialogue.conditions[index].is_started:
				dialogue.conditions[index].is_started = true
				play_dialogue(dialogue, dialogue_condition)

func play_dialogue(dialogue: Dialogue, dialogue_start: String = "default"):
	DialogueManager.show_dialogue_balloon_scene(
		dialogue.baloon_type,
		dialogue.dialogue_resource,
		dialogue_start
	)
	await DialogueManager.dialogue_ended

func _on_item_found(item: Item) -> void:
	if item.is_collectable:
		disable_item(item) 
	item_found.emit(item, self)

func _on_location_switch_requested(requested_location_name: String):
	location_switch_requested.emit(requested_location_name)

func get_available_hints(player_items: Array) -> Array[String]:
	var results: Array[String] = []
	for hint in hints:
		if hint.is_valid(player_items):
			results.append(hint.hint_text)
	return results

func update_items_visibility():
	for item in items:
		if case.inventory.has(item) or case.interactions.has(item):
			item.mark_found()
			disable_item(item)

func disable_item(item):
	item.disabled = true
	if item.is_collectable:
		item.hide()

func get_item_by_name(item_name: String) -> Item:
	for item in items:
		if item.item_name == item_name:
			return item
	#FIXME add handle no item found
	return null

func update_hint_text(player_items):
	var valid_hints = get_available_hints(player_items)
	#FIXME choose one hint when several available
	if valid_hints:
		hint_text = valid_hints[0]
		print("Hint to be shown: %s" %[hint_text])
		if $Helpsystem:
			$Helpsystem.call_deferred("set_hint_text")
