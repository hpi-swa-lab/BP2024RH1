extends Resource

class_name  Event

@export var event_name: String
@export var location_name: String
@export var start_condition: Condition

func is_valid(player_items: Array) -> bool:
	if start_condition:
		return start_condition.is_satisfied(player_items)
	return false
