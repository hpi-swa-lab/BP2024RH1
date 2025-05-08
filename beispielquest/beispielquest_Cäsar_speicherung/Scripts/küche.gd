extends Node2D


func _on_fenster_abdrücke_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#if event is InputEventMouseButton and Global.Fenster_picked == false:
	var current_scene = get_tree().current_scene.name.to_lower()
	if event is InputEventMouseButton:
		DialogueManager.show_dialogue_balloon(load("res://dialogues/Küche.dialogue"), "Fenster")
		
		CaseManager.mark_collectable_found(current_scene, "Fenster")
		
