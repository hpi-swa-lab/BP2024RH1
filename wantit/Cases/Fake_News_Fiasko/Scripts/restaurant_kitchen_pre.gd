extends Location

func _on_cupboard_half_open_pressed() -> void:
	%"Cupboard open".show()
	%"Cupboard halfOpen".hide()

func _on_cupboard_open_pressed() -> void:
	%"Cupboard open".hide()
	%"Cupboard halfOpen".show()
