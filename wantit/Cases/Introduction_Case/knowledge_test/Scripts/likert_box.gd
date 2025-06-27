extends VBoxContainer

@onready var question_label: Label = $QuestionLabel
@onready var answer_buttons: Array = [$Scale/A1, $Scale/A2, $Scale/A3, $Scale/A4, $Scale/A5, $Scale/A6, $Scale/A7]


signal answer_chosen(value: int)

func _ready():
	for i in range(7):
		var btn = answer_buttons[i]
		btn.value = i
		btn.connect("answer_selected", Callable(self, "_on_answer_selected"))

func show_question(q: Dictionary):
	question_label.text = q["question"]
	

func _on_answer_selected(value: int):
	answer_chosen.emit(value)
