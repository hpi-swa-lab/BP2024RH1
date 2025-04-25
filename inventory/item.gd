extends Button

@export var inventory: Control

func _on_pressed() -> void:
	inventory.add_item(self)
	self.hide()
