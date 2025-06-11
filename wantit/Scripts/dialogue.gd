extends Resource
class_name Dialogue

@export var dialogue_resource: DialogueResource
@export var is_dialogue: bool
@export var is_monologue: bool
var is_started: bool = false
var baloon_type: String
@export var conditions: Array[DialogueCondition] 

var monologue_baloon_path: String = "res://dialogue_balloons/monologue/balloon_monologue.tscn"
var dialogue_baloon_path: String = "res://dialogue_balloons/monologue/balloon_monologue.tscn"

func _init():
	set_baloon_type()	

func set_baloon_type():
	if is_dialogue:
		baloon_type = dialogue_baloon_path
	else:
		baloon_type = monologue_baloon_path

func choose_dialogue_under_condition(player_items: Array):
	for condition in conditions:
		if is_subset(condition.dialogue_conditions, player_items):
			return condition.dialogue_start
		
func is_subset(subset: Array, superset: Array) -> bool:
	for item in subset:
		if not superset.has(item):
			return false
	return true

func has_condition():
	if conditions.is_empty():
		return false
	return true
