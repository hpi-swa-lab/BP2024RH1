extends Node


func _ready() -> void:
	GameSaver.load_game()
	if Global.current_scene_path != "":
		SceneSwitcher.switch_to_scene(Global.current_scene_path)
	

func switch_to_scene(scene_path: String):
	var scene = load(scene_path).instantiate()
	if get_tree().current_scene:
		get_tree().current_scene.queue_free()
	get_tree().root.call_deferred("add_child", scene)
	await get_tree().process_frame
	get_tree().current_scene = scene

	apply_collectables_state(scene)
	#apply_noncollectables_state(scene)
	if scene.has_method("start_scene"):
		scene.start_scene()
		
	Global.current_scene_path = scene_path
	GameSaver.save_game()


func apply_collectables_state(scene_node: Node):
	var scene_name = scene_node.name.to_lower()
	var collectable_states = Global.case.get("scene_collectables_found", {}).get(scene_name, {})
	
	for node in scene_node.get_tree().get_nodes_in_group("collectables"):
		var is_collected = collectable_states.get(node.name, false)
		node.visible = not is_collected
		if node.has_method("set_disabled"):
			node.disabled = is_collected
			
			
func apply_noncollectables_state(scene_node: Node):
	var scene_name = scene_node.name.to_lower()
	var noncollectable_states = Global.case.get("scene_noncollectables_found", {}).get(scene_name, {})
	
	for node in scene_node.get_tree().get_nodes_in_group("non-collectables"):
		var is_collected = noncollectable_states.get(node.name, false)
		if node.has_method("set_disabled"):
			node.disabled = is_collected
