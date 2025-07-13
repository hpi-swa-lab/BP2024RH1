extends Resource
class_name  Event

@export var event_name: String
@export var location_name: String
@export var start_condition: Condition
var has_started: bool = false

func is_valid(player_items: Array) -> bool:
	if start_condition and not has_started:
		return start_condition.is_satisfied(player_items)
	return false
