extends Resource
class_name Dialogue

@export var dialogue_resource: DialogueResource
@export var is_dialogue: bool:
	get: return is_dialogue
	set(v):
		is_dialogue = v
		set_baloon_type()

var baloon_type: String
@export var dialogue_triggers: Array[DialogueTrigger]
@export var start_automatically: bool = true
var monologue_baloon_path: String = "res://dialogue_balloons/monologue/balloon_monologue.tscn"
var dialogue_baloon_path: String = "res://dialogue_balloons/balloon.tscn"

func set_baloon_type():
	if is_dialogue:
		baloon_type = dialogue_baloon_path
	else:
		baloon_type = monologue_baloon_path

func choose_dialogue_trigger_by_requierements(player_items: Array):
	var best_match = null
	for condition in dialogue_triggers:
		if is_subset(condition.required_items, player_items) and not condition.was_played:
			if best_match == null or best_match.required_items.size() < condition.required_items.size():
				best_match = condition
				condition.was_played = true
	
	if best_match != null:#and best_match.required_items.size() > 0:
		return best_match
	else:
		return null
	
func is_subset(subset: Array, superset: Array) -> bool:
	for item in subset:
		if not superset.has(item):
			return false
	return true

func get_condition_index_by_dialogue_start(target: String):
	for i in dialogue_triggers.size():
		if dialogue_triggers[i].dialogue_start == target:
			return i
	return null
