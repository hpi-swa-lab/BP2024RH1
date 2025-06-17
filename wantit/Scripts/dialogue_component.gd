extends Node

@export var dialogue: Dialogue
var inventory_provider: Resource  # Should support get_player_items()
@export var trigger_on_ready: bool = true

func _ready():
	if trigger_on_ready:
		call_deferred("start_dialogue")

func start_dialogue():
	var starting_point = get_dialogue_start()
	if starting_point:
		await DialogueManager.show_dialogue_balloon_scene(
			dialogue.baloon_type,
			dialogue.dialogue_resource,
			starting_point
		)

func get_dialogue_start():# -> String:
	if not dialogue or not inventory_provider:
		return null

	var player_items = inventory_provider.get_player_items()
	var dialogue_condition = dialogue.choose_dialogue_by_requierements(player_items)
	return dialogue_condition
	#if dialogue_condition:
		#var index = dialogue.get_condition_index_by_dialogue_start(dialogue_condition)
		#if index != null and not dialogue.conditions[index].is_started:
			#dialogue.conditions[index].is_started = true
			##await play_dialogue(dialogue, dialogue_condition)
	
#func on_item_pressed(item: Item):
	#start_dialogue()
