extends Button

class_name And_Button

var input_1: bool = false
@export var input_connection_1: Connection
var input_2: bool = false
@export var input_connection_2: Connection

@export var output_connection: Connection
var output: bool = false

func _process(_delta: float) -> void:
	
	input_1 = input_connection_1.output
	input_2 = input_connection_2.output
	
	if input_1 && input_2:
		output = true
	else:
		output = false
	
	output_connection.input = output
