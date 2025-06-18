extends Resource
class_name Dialogue

@export var dialogue_resource: DialogueResource
@export var dialogue_id: String
@export var is_dialogue: bool
@export var is_monologue: bool
var baloon_type: String
@export var conditions: Array[DialogueCondition] 

var monologue_baloon_path: String = "res://dialogue_balloons/balloon.tscn"
var dialogue_baloon_path: String = "res://dialogue_balloons/monologue/balloon_monologue.tscn"

func _init():
	set_baloon_type()	

func set_baloon_type():
	if is_dialogue:
		baloon_type = dialogue_baloon_path
	else:
		baloon_type = monologue_baloon_path

func choose_dialogue_by_requierements(player_items: Array):
	var best_match = null
	for condition in conditions:
		if is_subset(condition.required_items, player_items):
			if best_match == null or best_match.required_items.size() < condition.required_items.size():
				best_match = condition
	
	if best_match != null:#and best_match.required_items.size() > 0:
		return best_match.dialogue_start
	else:
		return null
	
func is_subset(subset: Array, superset: Array) -> bool:
	for item in subset:
		if not superset.has(item):
			return false
	return true

func get_condition_index_by_dialogue_start(target: String):
	for i in conditions.size():
		if conditions[i].dialogue_start == target:
			return i
	return null
