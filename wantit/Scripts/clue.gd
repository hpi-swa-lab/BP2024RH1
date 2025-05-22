extends TextureButton

class_name Clue

signal clue_found(clue: Clue)

@export var clue_name: String
@export var is_collectable: bool
var is_found: bool
@export var clue_dialogue_path: String
@export var clue_dialogue_start: String


func _on_pressed():
	if is_found:
		return

	mark_found()
	if has_dialogue():
		DialogueManager.show_dialogue_balloon(load(clue_dialogue_path), clue_dialogue_start)
	emit_signal("clue_found", self)


func mark_found():
	is_found = true

func has_dialogue() -> bool: ###check that all dialogues (must) have dialogue start
	return self.clue_dialogue_path != "" and self.clue_dialogue_start != ""
