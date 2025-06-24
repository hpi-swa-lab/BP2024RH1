extends Resource

class_name  EventTrigger

@export var event_name: String
@export var location_name: String
@export var event_condition: Condition

func is_valid(player_items: Array) -> bool:
	if event_condition:
		return event_condition.is_satisfied(player_items)
	return false
