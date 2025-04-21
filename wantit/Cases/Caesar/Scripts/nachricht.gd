extends Button

@export var dialogue: String
@export var dialogue_start: String

func _ready() -> void:
	if dialogue != "Küche" and Globals.had_tutorial == false:
		self.visible = false

func _on_pressed() -> void:
	if dialogue != "":
		DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/" + dialogue + ".dialogue"), dialogue_start)
		Globals.items_found += 1
		self.visible = false
