extends Control

const INTERACTABLE_BALLOON = preload("res://dialogue_balloon/interactable_balloon.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if State.ending == "good":
		show_good_endscreen()
	elif State.ending == "bad":
		show_bad_endscreen()
	else:
		pass

func show_good_endscreen() -> void:
	DialogueManager.show_dialogue_balloon_scene(INTERACTABLE_BALLOON, load("res://ending.dialogue"), "good", [])
	
func show_bad_endscreen() -> void:
	DialogueManager.show_dialogue_balloon_scene(INTERACTABLE_BALLOON, load("res://ending.dialogue"), "bad", [])
