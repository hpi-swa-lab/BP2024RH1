extends Control

class_name Helpsys

@onready var questionmark: Button = $Questionmark
@onready var hints: Control = $Hints



func _on_questionmark_pressed() -> void:
	questionmark.hide()
	hints.show()
	
	


func _on_close_pressed() -> void:
	questionmark.show()
	hints.hide()
