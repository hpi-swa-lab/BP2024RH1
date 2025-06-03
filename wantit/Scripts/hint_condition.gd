extends Resource

class_name HintCondition

enum Mode { ALL, ANY, NONE }

@export var mode: Mode = Mode.ALL
@export var required_items: Array[String] = []

func is_satisfied(player_items: Array):
	match mode:
		Mode.ALL:
			for item in required_items:
				if not player_items.has(item):
					return false
			return true
		Mode.ANY:
			for item in required_items:
				if player_items.has(item):
					return true
			return false
		Mode.NONE:
			for item in required_items:
				if player_items.has(item):
					return false
			return true
