# main.gd
extends Node2D

const ASSET_PATH := "res://Cases/Code_From_The_Ashes/knowledge_test/Assets/"
const CASE := "CAESR"

@onready var question_box = $QuestionWrap/QuestionBox

var results = []
var current_question = 0
var questions = []

func _ready():
	load_questions()
	show_next_question()
	question_box.ASSET_PATH=ASSET_PATH
	question_box.connect("answer_chosen", Callable(self, "_on_answer_chosen"))
	question_box.text_answer_submitted.connect(_on_text_answer_submitted)

func load_questions():
	var file = FileAccess.open((ASSET_PATH+"question_data.json"), FileAccess.READ)
	questions = JSON.parse_string(file.get_as_text())

func show_next_question():
	if current_question >= questions.size():
		print(CASE+" Quiz Finished! Final score: ", results)
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
