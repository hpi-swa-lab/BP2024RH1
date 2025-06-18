extends Node
class_name DialogueComponent

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
	
#func on_item_pressed(item: Item):
	#start_dialogue()

func get_played_dialogues():
	var started_indices = []
	for i in dialogue.conditions.size():
		if dialogue.conditions[i].is_started:
			started_indices.append(i)
	return {
		"id": dialogue.dialogue_id,
		"started_conditions": started_indices
	}
	
func load_saved_data():
	pass
