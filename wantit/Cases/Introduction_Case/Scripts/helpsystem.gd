extends Control

@export var hints: Array[Hint] = []
var inventory_provider # Should support get_player_items()
@onready var question_mark = $Question_mark
@onready var helpscreen = $Helpscreen
#@onready var location = get_parent()

func _ready() -> void:
	helpscreen.connect("display_question_mark", display_question_mark)
	question_mark.connect("display_helpscreen", display_helpscreen)
	update_hint_text()

func display_question_mark():
	await get_tree().create_timer(5).timeout
	question_mark.visible = true

func display_helpscreen():
	helpscreen.visible = true
	
func update_hint_text() -> void:
	var player_items = inventory_provider.get_player_items()
	var hint_text = get_available_hints(player_items)
	helpscreen.set_hint_text(hint_text)

func get_available_hints(player_items: Array) -> Array[String]:
	var results: Array[String] = []
	for hint in hints:
		if hint.is_valid(player_items):
			results.append(hint.hint_text)
	return results
