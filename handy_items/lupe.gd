extends Button

var cursor = Image.new()
var alreadyPressed: bool = false
signal searching(start: bool)

func _ready() -> void:
	cursor = Image.load_from_file("res://Assets/magnifying-glass.png")

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
