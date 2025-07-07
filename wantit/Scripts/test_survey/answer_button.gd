extends Button

signal answer_selected(is_correct)

var is_correct: bool = false
var value: int

func _ready():
	connect("pressed", Callable(self, "_on_pressed"))

func _on_pressed():
	if(!value):
		answer_selected.emit(is_correct)
	else:
		answer_selected.emit(value)
 
