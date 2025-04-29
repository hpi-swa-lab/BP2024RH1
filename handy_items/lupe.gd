# Magnifying glass - pretty self explanatory, emits signal searching when pressed and changes cursor icon

extends Button

var cursor = Image.new()
var alreadyPressed: bool = false
signal searching(start: bool)

func _ready() -> void:
	cursor = load("res://Assets/magnifying-glass.png").get_image()

func _on_pressed() -> void:
	if not alreadyPressed:
		alreadyPressed = true
		cursor.resize(80, 80)
		Input.set_custom_mouse_cursor(cursor)
		searching.emit(true)
	else:
		alreadyPressed = false
		Input.set_custom_mouse_cursor(null)
		searching.emit(false)
