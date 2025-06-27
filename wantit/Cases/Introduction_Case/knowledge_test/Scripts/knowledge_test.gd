# main.gd
extends Node2D

@onready var question_box = $QuestionWrap/QuestionBox
#@onready var score_label = $ScoreLabel
#@onready var timer = $Timer

var score = 0
var current_question = 0
var questions = []

func _ready():
	load_questions()
	show_next_question()
	question_box.connect("answer_chosen", Callable(self, "_on_answer_chosen"))

func load_questions():
	var file = FileAccess.open("res://Cases/Introduction_Case/knowledge_test/Assets/question_data.json", FileAccess.READ)
	questions = JSON.parse_string(file.get_as_text())

func show_next_question():
	if current_question >= questions.size():
		print("Quiz Finished! Final score: ", score)
		return
	question_box.show_question(questions[current_question])

func _on_answer_chosen(correct: bool):
	if correct:
		score += 100
	else:
		score -= 50
	current_question += 1
	show_next_question()

func _on_Timer_timeout():
	current_question += 1
	show_next_question()
