extends Node

var current_scene = null

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
# Der Szenenwechsel wird erst ausgeführt wenn es idle ist (laut docs bevorzugt)
func switch_scene(scene_path):
	call_deferred("_deferred_switch_scene", scene_path)
	
func _deferred_switch_scene(scene_path):
	current_scene.free()
	var s = load(scene_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
