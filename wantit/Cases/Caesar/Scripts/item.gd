extends Button

@export var dialogue: String
@export var dialogue_start: String

func _on_pressed():
	Globals.items_found += 1
	var Globals_name = self.get_name() + "_picked"
	if Globals_name in Globals:
		if Globals.get(Globals_name) == false:
			Globals.set(Globals_name, true)
	else:
		print("Did you spell the item_name and Globals name the same?")
	DialogueManager.show_dialogue_balloon(load("res://Cases/Caesar/dialogues/" + dialogue + ".dialogue"), dialogue_start)
	self.visible = false
	self.disabled = true
