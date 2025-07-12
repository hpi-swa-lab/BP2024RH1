extends Control
class_name Helpsystem

var hint_num = 0
var hints: Array[Hint] = []
var inventory_provider
@onready var helpscreen_closed = $Question_mark
@onready var helpscreen = $Helpscreen

signal all_hints_used()

func _ready() -> void:
	helpscreen.connect("helpsystem_closed", set_closed_state)
	helpscreen_closed.connect("helpsystem_opened", set_opened_state)
	set_closed_state()
	connect("all_hints_used", disable_helpsystem)

func set_hints(_hints: Array[Hint]) -> void:
	hints = _hints

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
	var hint = get_available_hint(player_items)
	if hint:
		helpscreen.set_hint_text(hint.hint_text)
		hint.mark_shown()
	else:
		all_hints_used.emit()

func get_available_hint(player_items: Array):
	for hint in hints:
		if hint.is_valid(player_items) and hint.is_shown == false:
			Analytics.add_hint_analytics(get_parent().location_name + str(hint_num))
			hint_num += 1
			return hint

func get_used_hints() -> Array:
	var used_hints = []
	for hint in hints:
		if hint.is_shown == true:
			used_hints.append(hint.hint_text)
	return used_hints
	
func set_used_hints(data: Array) -> void:
	for hint in hints:
		if hint.hint_text in data:
			hint.is_shown = true

func disable_helpsystem():
	get_parent().remove_child(self)
