extends Line2D

class_name Connection

@export var input: bool = false
@export var output: bool = false 

func _process(delta: float) -> void:
	if input:
		default_color = "ff1100"
	else:
		default_color = "ffffff"
	
	
	output = input
