extends Button

class_name change_room_button

@export var path_switch_to_scene : String

func _on_pressed() -> void:
	get_tree().change_scene_to_file(path_switch_to_scene)
