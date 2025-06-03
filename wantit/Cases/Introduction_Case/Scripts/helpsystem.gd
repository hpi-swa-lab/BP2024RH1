extends Control

@onready var question_mark = $Question_mark
@onready var helpscreen = $Helpscreen
@onready var location = get_parent()

func _ready() -> void:
	helpscreen.connect("display_question_mark", display_question_mark)
	question_mark.connect("display_helpscreen", display_helpscreen)
	
	set_hint_text()


func display_question_mark():
	await get_tree().create_timer(5).timeout
	question_mark.visible = true

func display_helpscreen():
	helpscreen.visible = true
	
func set_hint_text() -> void:
	$Helpscreen.set_hint_text(location.hint_text)

#func _on_helpscreen_hide_question_mark() -> void:
	#question_mark.visible = false
	#print("not visible")
