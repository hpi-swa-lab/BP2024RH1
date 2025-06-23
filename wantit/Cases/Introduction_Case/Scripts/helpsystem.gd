extends Control
class_name Helpsystem

var hints: Array[Hint] = []
var inventory_provider
@onready var helpscreen_closed = $Question_mark
@onready var helpscreen = $Helpscreen

func _ready() -> void:
	helpscreen.connect("helpsystem_closed", set_closed_state)
	helpscreen_closed.connect("helpsystem_opened", set_opened_state)
	set_closed_state()

func set_hints(_hints: Array[Hint]) -> void:
	hints = _hints
	update_hint_text()

func set_closed_state() -> void:
	helpscreen.visible = false
	await get_tree().create_timer(5).timeout
	helpscreen_closed.visible = true

func set_opened_state() -> void:
	update_hint_text()
	helpscreen.visible = true
	helpscreen_closed.visible = false
	
func update_hint_text() -> void:
	var player_items = inventory_provider.get_player_items()
	var hint_text = get_available_hints(player_items)
	helpscreen.set_hint_text("\n".join(hint_text))

func get_available_hints(player_items: Array) -> Array[String]:
	var results: Array[String] = []
	for hint in hints:
		if hint.is_valid(player_items):
			results.append(hint.hint_text)
	return results
