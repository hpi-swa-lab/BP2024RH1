# main.gd
extends Node2D

@onready var question_box = $QuestionWrap/QuestionBox
#@onready var score_label = $ScoreLabel
#@onready var timer = $Timer

var results = []
var current_question = 0
var questions = []

func _ready():
	load_questions()
	show_next_question()
	question_box.connect("answer_chosen", Callable(self, "_on_answer_chosen"))
	question_box.text_answer_submitted.connect(_on_text_answer_submitted)

func load_questions():
	var file = FileAccess.open("res://Cases/Introduction_Case/knowledge_test/Assets/question_data.json", FileAccess.READ)
	questions = JSON.parse_string(file.get_as_text())

func show_next_question():
	if current_question >= questions.size():
		print("Quiz Finished! Final score: ", results)
		return
	question_box.show_question(questions[current_question])

func _on_answer_chosen(correct: bool):
	results.append(correct)
	current_question += 1
	show_next_question()

func _on_Timer_timeout():
	current_question += 1
	show_next_question()

func _on_text_answer_submitted(answer: String):
	# print("Spieler hat geschrieben:", answer)
	results.append(answer)
	current_question += 1
	show_next_question()
