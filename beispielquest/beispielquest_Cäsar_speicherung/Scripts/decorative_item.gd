extends Button

@export var dialogue: String
@export var dialogue_start: String

func _on_pressed() -> void:
	var global_name = self.get_name() + "_picked"
	if global_name in Global:
		if Global.get(global_name) == false:
			Global.set(global_name, true)
			DialogueManager.show_dialogue_balloon(load("res://dialogues/" + dialogue + ".dialogue"), dialogue_start)
	else:
		print("Did you spell the item_name and global name the same?")
