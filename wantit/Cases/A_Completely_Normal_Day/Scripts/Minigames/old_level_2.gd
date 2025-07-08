extends Control

signal ziel_input_true
signal ziel_input_false

var current_active_starts: int = 0

#für den fall das ausversehen current_acrive_starts im interface auf was anderes gesetzt wird
func _ready() -> void:
	current_active_starts = 0

func _on_ziel_ziel_input_false() -> void:
	emit_signal("ziel_input_false")

func _on_ziel_ziel_input_true() -> void:
	emit_signal("ziel_input_true")


func _on_start_or_right_toggled(toggled_on: bool) -> void:
	update_current_active_starts(toggled_on)


func _on_start_or_left_toggled(toggled_on: bool) -> void:
	update_current_active_starts(toggled_on)


func _on_start_and_left_toggled(toggled_on: bool) -> void:
	update_current_active_starts(toggled_on)


func _on_start_for_two_or_left_and_right_toggled(toggled_on: bool) -> void:
	update_current_active_starts(toggled_on)


func _on_start_for_two_and_kitchen_or_right_toggled(toggled_on: bool) -> void:
	update_current_active_starts(toggled_on)


func update_current_active_starts(toggled_on: bool) -> void:
	if toggled_on:
		current_active_starts += 1
	else:
		current_active_starts -= 1
	print(current_active_starts)
