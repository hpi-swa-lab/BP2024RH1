extends Node


func _ready():
	print("CaseManager ready")


func mark_dialogue_shown(dialogue_id: String) -> void:
	Global.case["dialogues_shown"][dialogue_id] = true
	print("Dialogue shown:", dialogue_id)


func mark_collectable_found(scene_name: String, item_name: String) -> void:
	if not Global.case["scene_collectables_found"].has(scene_name):
		Global.case["scene_collectables_found"][scene_name] = {}

	if !Global.case["scene_collectables_found"][scene_name].get(item_name, false):
		Global.case["scene_collectables_found"][scene_name][item_name] = true
		print("Collectable found: ", item_name, " in ", scene_name)
		_check_case_completion()


func mark_noncollectable_found(scene_name: String, item_name: String) -> void:
	if not Global.case["scene_noncollectables_found"].has(scene_name):
		Global.case["scene_noncollectables_found"][scene_name] = {}

	if !Global.case["scene_noncollectables_found"][scene_name].get(item_name, false):
		Global.case["scene_noncollectables_found"][scene_name][item_name] = true
		print("Non-collectable found: ", item_name, " in ", scene_name)
		_check_case_completion()


func go_to_next_scene():
	var current_scene = Global.current_scene_path.get_file().get_basename().to_lower()
	var flow = Global.case.get("scene_flow", {})
	var next_scene = flow.get(current_scene, null)
	
	if next_scene:
		SceneSwitcher.switch_to_scene(next_scene)
	else:
		print("🚫 No next scene defined for: ", current_scene)	


func _check_case_completion() -> void:
	if _all_collectables_found():
		print("✅ All clues found! Moving to next scene...")
		_transition_to_next_scene()


func _all_collectables_found() -> bool:
	for scene_data in Global.case["scene_collectables_found"].values():
		for status in scene_data.values():
			if status == false:
				return false
	return true


func _transition_to_next_scene() -> void:
	var next_scene = Global.case.get("next_scene", "")
	Global.office_szene = 1 #only for this case
	if next_scene != "":
		get_tree().change_scene_to_file(next_scene)
	else:
		print("⚠️ No next scene specified in case data.")
