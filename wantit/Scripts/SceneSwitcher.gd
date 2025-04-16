extends Node

# Der SceneSwitcher wird zum Aufrufen der Szenen benutzt.
# Der Aufruf folgt diesem Muster: SceneSwitcher.switch_scene("scenePath")
# Man kann ansonsten das ganze auch mit eine PackedScene statt dem scenePath aufrufen, wegen den Cases

var currentScene = null

func _ready() -> void:
	var root = get_tree().root
	currentScene = root.get_child(root.get_child_count() - 1)
	
# Der Szenenwechsel wird erst ausgeführt wenn es idle ist (laut docs bevorzugt)
func switch_scene(scenePath):
	call_deferred("_deferred_switch_scene", scenePath)
	
func _deferred_switch_scene(scenePath):
	currentScene.free()
	if scenePath is PackedScene:				#Das hier ist nur drin weil ich sicher gehen will, dass die Fälle eine valide Szene übergeben bekommen
		currentScene = scenePath.instantiate()
	else:
		var s = load(scenePath)
		currentScene = s.instantiate()
	get_tree().root.add_child(currentScene)
	get_tree().current_scene = currentScene
