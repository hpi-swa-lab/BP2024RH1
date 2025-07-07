extends Control

@onready var pic = $TextureRect

func _ready() -> void:
	visible = false

func _on_break_in_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		visible = true


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not pic.get_global_rect().has_point(event.position):
			visible = false
