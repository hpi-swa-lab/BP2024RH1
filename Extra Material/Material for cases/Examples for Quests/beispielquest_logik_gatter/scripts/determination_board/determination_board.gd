extends Control

@export var NAME_OF_CASE: String

func _on_button_pressed() -> void:
	#wenn schließen button gepressed wird
	queue_free()
