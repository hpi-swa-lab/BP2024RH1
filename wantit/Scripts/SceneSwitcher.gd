extends Node

# Der SceneSwitcher wird zum Aufrufen der Szenen benutzt.
# Der Aufruf folgt diesem Muster: SceneSwitcher.switch_scene("scene_path")
# Man kann ansonsten das ganze auch mit eine PackedScene statt dem scene_path aufrufen, wegen den Cases

var current_scene = null

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
# Der Szenenwechsel wird erst ausgeführt wenn es idle ist (laut docs bevorzugt)
func switch_scene(scene_path):
	call_deferred("_deferred_switch_scene", scene_path)
	
func _deferred_switch_scene(scene_path):
	current_scene.free()
	if scene_path is PackedScene:				#Das hier ist nur drin weil ich sicher gehen will, dass die Fälle eine valide Szene übergeben bekommen
		current_scene = scene_path.instantiate()
	else:
		var s = load(scene_path)
		current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
