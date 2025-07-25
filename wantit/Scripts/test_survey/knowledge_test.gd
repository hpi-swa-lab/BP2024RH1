# main.gd
extends Location


var ASSET_PATH := "res://Assets/knowledge_tests/"
var CASE := "caesr"
@onready var question_box = $QuestionWrap/QuestionBox
@onready var skip_button = $QuestionWrap/QuestionBox/SkipButton

var results = []
var current_question = 0
var questions = []
var startTime : int = 0
var durationAnswers : Array[int]

func _ready():
	super._ready()
	
	_choose_case()
	load_questions()
	show_next_question()
	question_box.connect("answer_chosen", Callable(self, "_on_answer_chosen"))
	question_box.text_answer_submitted.connect(_on_text_answer_submitted)
	skip_button.connect("pressed", Callable(self, "_on_skip_pressed"))

func load_questions():
	var file = FileAccess.open((ASSET_PATH+"question_data.json"), FileAccess.READ)
	questions = JSON.parse_string(file.get_as_text())

func show_next_question():
	var t : int = Time.get_ticks_msec() / 1000.0
	
	if current_question > 0: # only record duration after the first question
		durationAnswers.append(t - startTime)
	startTime = t
	if current_question >= questions.size():
		durationAnswers.append((Time.get_ticks_msec() / 1000.0) - startTime)
		print(CASE+" "+ self.location_name+" Quiz Finished! Final score: ", durationAnswers, results)
		var phase = "pre"
		if self.location_name == "PostTest": phase = "post"
		Analytics.add_knowledge_test_analytics(phase, results, durationAnswers)
		var item = Item.new()
		item.item_name = self.location_name + " completed"
		item.is_collectable = false
		item_found.emit(item, self)
	else:
		question_box.show_question(questions[current_question])

func _on_skip_pressed():
	results.append(null)
	current_question += 1
	show_next_question()

func _on_answer_chosen(correct: bool):
	results.append(correct)
	current_question += 1
	show_next_question()

func _on_text_answer_submitted(answer: String):
	# print("Spieler hat geschrieben:", answer)
	results.append(answer)
	current_question += 1
	show_next_question()
	
func _choose_case():
	if case!=null:
		CASE = case.case_slug
	else:
		CASE = "pixel"
	ASSET_PATH += (CASE+'/')
	question_box.ASSET_PATH=ASSET_PATH
