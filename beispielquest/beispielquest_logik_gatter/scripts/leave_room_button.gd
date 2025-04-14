extends Control

@export var switch_to_scene : PackedScene

func _on_pressed() -> void:
	get_tree().change_scene_to_packed(switch_to_scene)
