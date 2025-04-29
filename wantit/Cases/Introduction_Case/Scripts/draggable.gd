extends Button

@export var correctClue: Button

var dragging: bool
signal check


func _on_button_down() -> void:
	self.position = get_global_mouse_position() - self.size / 2
	dragging = true
	set_process_input(true)

func _on_button_up() -> void:
	dragging = false
	set_process_input(false)
	check.emit()

func _input(event: InputEvent) -> void:
	if dragging:
		if event is InputEventMouseMotion:
			self.position = event.position - self.size / 2
