extends Control

@onready var hint_text = $MarginContainer/Hint_text
signal helpsystem_closed

func _ready() -> void:
	visible = false

func set_hint_text(text: String) -> void:
	hint_text.text = text

func _on_close_button_pressed() -> void:
	helpsystem_closed.emit()
