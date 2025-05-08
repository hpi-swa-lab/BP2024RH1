extends Button

@export var dialogue: String
@export var dialogue_start: String

func _on_pressed():
	var current_scene = get_tree().current_scene.name.to_lower()
	
	CaseManager.mark_noncollectable_found(current_scene, name)
	DialogueManager.show_dialogue_balloon(
			load("res://dialogues/" + current_scene + ".dialogue"),
			name
		)
