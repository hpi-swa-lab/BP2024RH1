extends Resource
class_name Hint

@export var hint_text: String
@export var hint_condition: Condition
var is_shown: bool = false

func is_valid(player_items: Array) -> bool:
	if hint_condition:
		return hint_condition.is_satisfied(player_items)
	return false

func mark_shown() -> void:
	is_shown = true
