extends Node3D

func _ready() -> void:
	CaseManager.add_Case("Test1", load("res://Scenes/testscene.tscn"))
	CaseManager.add_Case("Test2", load("res://Scenes/testscene.tscn"))
	CaseManager.add_Case("Test3", load("res://Scenes/testscene.tscn"))

func _on_pc_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if not Globals.selectedCase:
			SceneSwitcher.switch_scene("res://Scenes/fallübersicht.tscn")
		else: 
			print("Finish your Case first")


func _on_map_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		SceneSwitcher.switch_scene("res://Scenes/map.tscn")
