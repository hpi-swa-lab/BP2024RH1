# main.gd
extends Node2D

@onready var slider_box = $QuestionWrap/SliderBox
#@onready var score_label = $ScoreLabel
#@onready var timer = $Timer

var score = []
var current_question = 0
var questions = []

func _ready():
	load_questions()
	show_next_question()
	slider_box.connect("answer_chosen", Callable(self, "_on_answer_chosen"))


func load_questions():
	var file = FileAccess.open("res://Cases/Introduction_Case/knowledge_test/Assets/survey_questions.json", FileAccess.READ)
	questions = JSON.parse_string(file.get_as_text())

func show_next_question():
	if current_question >= questions.size():
		print("IC Survey done! They chose: ", score)
		return
	slider_box.show_question(questions[current_question])

func _on_answer_chosen(value):
	score.append(value) 
	current_question += 1
	show_next_question()
