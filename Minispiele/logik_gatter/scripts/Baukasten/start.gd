extends CheckButton

class_name Start_button

@export var output_connection: Connection 
var input: bool

func _process(delta: float) -> void:
	if input:
		output_connection.input = true
	else:
		output_connection.input = false


func _on_toggled(toggled_on: bool) -> void:
	input = toggled_on
	if input:
		text = "An"
	else:
		text = "Aus"
