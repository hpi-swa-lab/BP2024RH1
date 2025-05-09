extends TextureButton

var cursor = Image.new()
var alreadyPressed: bool = false
signal searching(start: bool)

func _ready() -> void:
	cursor = load("res://Assets/magnifying-glass.png").get_image()

func _on_button_down() -> void:
	cursor.resize(80, 80)
	Input.set_custom_mouse_cursor(cursor)
	searching.emit(true)

func _on_button_up() -> void:
	Input.set_custom_mouse_cursor(null)
	searching.emit(false)
