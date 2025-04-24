extends Button

@export var dialogue: String
@export var dialogue_start: String

func _on_pressed() -> void:
	if dialogue != "":
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/" + dialogue + ".dialogue"), dialogue_start)
		Globals.CaseGlobals.items_found += 1
		self.visible = false
