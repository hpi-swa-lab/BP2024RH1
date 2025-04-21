extends Button

@export var dialogue: String
@export var dialogue_start: String

func _on_pressed():
	Globals.items_found += 1
	var CaseString: String = ""
	if Globals.selectedCase != null:
		CaseString = "Cases/" + Globals.selectedCase.CaseName
	DialogueManager.show_dialogue_balloon(load("res://" + "/dialogues/" + dialogue + ".dialogue"), dialogue_start)
	self.visible = false
