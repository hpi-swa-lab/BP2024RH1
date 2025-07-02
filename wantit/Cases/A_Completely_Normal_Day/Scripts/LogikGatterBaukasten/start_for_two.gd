extends CheckButton

class_name Start_For_Two_button

@export var output_connection_1: Connection 
@export var output_connection_2: Connection 

var input: bool

func _process(delta: float) -> void:
	if input:
		output_connection_1.input = true
		output_connection_2.input = true
	else:
		output_connection_1.input = false
		output_connection_2.input = false


func _on_toggled(toggled_on: bool) -> void:
	input = toggled_on
	if input:
		text = "Quelle An"
	else:
		text = "Quelle Aus"
