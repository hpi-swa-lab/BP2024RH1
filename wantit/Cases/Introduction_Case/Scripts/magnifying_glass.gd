extends TextureButton

var cursor = Image.new()
var alreadyPressed: bool = false
signal searching(start: bool)

func _ready() -> void:
	cursor = texture_normal.get_image()

func _on_button_down() -> void:
	cursor.resize(100, 100)
	Input.set_custom_mouse_cursor(cursor)
	searching.emit(true)

func _on_button_up() -> void:
	Input.set_custom_mouse_cursor(null)
	searching.emit(false)
