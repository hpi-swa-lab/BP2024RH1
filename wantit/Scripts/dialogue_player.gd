extends Resource
class_name DialoguePlayer

@export var dialogue: Dialogue
@export var inventory_provider: Resource

func _init(_dialogue: Dialogue, _inventory_provider: Resource, data: Array) -> void:
	dialogue = _dialogue
	inventory_provider = _inventory_provider
	
	if not data.is_empty():
		restore_dialogues(data)

func activate():
	if dialogue and dialogue.start_automatically:
		start_dialogue()

func start_dialogue():
	var dialogue_trigger = get_dialogue_start()
	if dialogue_trigger and (not dialogue_trigger.is_started or dialogue_trigger.is_repeatable):
		DialogueManager.show_dialogue_balloon_scene(
			dialogue.baloon_type,
			dialogue.dialogue_resource,
			dialogue_trigger.start_marker
		)
		if not dialogue_trigger.is_repeatable:
			dialogue_trigger.is_started = true

func get_dialogue_start():
	if not dialogue or not inventory_provider:
		return null

	var player_items = inventory_provider.get_player_items()
	var trigger = dialogue.choose_dialogue_trigger_by_requierements(player_items)
	return trigger

func get_played_dialogues() -> Array:
	var start_markers = []
	for trigger in dialogue.dialogue_triggers:
		if trigger.is_started:
			start_markers.append(trigger.start_marker)
	return start_markers
	
func restore_dialogues(data: Array) -> void:
	for trigger in dialogue.dialogue_triggers:
		if data.has(trigger.start_marker):
			trigger.is_started = true

func reset_played_dialogues() -> void:
	for trigger in dialogue.dialogue_triggers:
		trigger.is_started = false
		trigger.was_played = false
