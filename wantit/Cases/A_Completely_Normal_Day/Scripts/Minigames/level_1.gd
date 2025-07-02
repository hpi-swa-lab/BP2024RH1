extends Control

signal ziel_input_true
signal ziel_input_false

func _on_ziel_ziel_input_false() -> void:
	emit_signal("ziel_input_false")

func _on_ziel_ziel_input_true() -> void:
	emit_signal("ziel_input_true")
