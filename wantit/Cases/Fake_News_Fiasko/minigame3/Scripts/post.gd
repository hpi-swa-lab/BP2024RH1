extends Node

class_name  post

@export var Profile_name: String
@export var Connected_post: Control
@export var is_relevant: bool
@export var is_convincing: bool

signal Post_selected(BigPost: Control) 

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		Post_selected.emit(Connected_post, self)
