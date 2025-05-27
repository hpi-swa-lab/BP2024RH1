extends Control

@onready var question_mark = $Question_mark
@onready var helpscreen = $Helpscreen
var hint_text: String

func _ready() -> void:
	helpscreen.connect("display_question_mark", display_question_mark)
	question_mark.connect("display_helpscreen", display_helpscreen)
	#var location = get_parent()
	#if location and location.has_variable("hint_text"):
		#hint_text = location.hint_text
	#else:
		#push_error("Parent node doesn't have a 'hint_text' field.")
	
func display_question_mark():
	await get_tree().create_timer(5).timeout
	question_mark.visible = true

func display_helpscreen():
	helpscreen.visible = true
	


#func _on_helpscreen_hide_question_mark() -> void:
	#question_mark.visible = false
	#print("not visible")
