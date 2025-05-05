extends Control

@onready var question_mark = $Question_mark
@onready var helpscreen = $Helpscreen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	helpscreen.connect("display_question_mark", display_question_mark)
	question_mark.connect("display_helpscreen", display_helpscreen)
	
func display_question_mark():
	await get_tree().create_timer(5).timeout
	question_mark.visible = true

func display_helpscreen():
	helpscreen.visible = true
	


#func _on_helpscreen_hide_question_mark() -> void:
	#question_mark.visible = false
	#print("not visible")
