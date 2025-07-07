extends TextureButton

signal helpsystem_opened

func _ready() -> void:
	visible = false

func _on_pressed() -> void:
	helpsystem_opened.emit()
