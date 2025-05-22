extends Resource

class_name Hint

@export var hint_text: String
@export var hint_condition: HintCondition

func is_valid(player_items: Array[String]) -> bool:
	if hint_condition:
		return hint_condition.is_satisfied(player_items)
	return false # If no condition is set, treat it as not valid
