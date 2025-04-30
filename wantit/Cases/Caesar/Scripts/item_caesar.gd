extends Button

@export var dialogue: String
@export var dialogue_start: String

func _on_pressed():
	Globals.CaseGlobals.items_found += 1
	var CaseString: String = ""
	if Globals.selectedCase != null:
		CaseString = "Cases/" + Globals.selectedCase.CaseName
	DialogueManager.show_dialogue_balloon(load("res://" + CaseString + "/dialogues/" + dialogue + ".dialogue"), dialogue_start)
	self.visible = false
