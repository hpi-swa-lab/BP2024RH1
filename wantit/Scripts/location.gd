extends Node #or Control?

class_name Location

@export var location_name: String
@export var case: Case
@export var location_path: String
@export var clues: Array[Clue] = []
@export var hints: Array[Hint] = [] # or just array of strings?
var intro_dialogue_path: String
var intro_dialogue_title: String

signal collectable_clue_found(clue: Clue)
signal non_collectable_clue_found(clue: Clue)
signal on_switch_location(location_name: String)

func _ready():
	connect("clue_found", Callable(self, "_on_clue_found"))
	# update_hint_text()

func _on_clue_found(clue: Clue) -> void:
	print("Clue: %s found in location: %s" % [clue.clue_name, self.location_name])
	if clue.is_collectable:
		emit_signal("collectable_clue_found", clue)
		disable_item(clue) 
	else:
		emit_signal("non_collectable_clue_found", clue)
		#update_hint_text()
	
#func _on_location_change_pressed():
	#pass`

func get_available_hints(player_items: Array[String]) -> Array[String]:
	var results: Array[String] = []
	for hint in hints:
		if hint.is_valid(player_items):
			results.append(hint.text)
	return results

func update_items_visibility():
	for item in clues:
		if case.interactions.has(item) or case.inventory.has(item):
			disable_item(item)

func disable_item(item):
	item.disabled = true
	item.hide()

#TODO add dialogues
