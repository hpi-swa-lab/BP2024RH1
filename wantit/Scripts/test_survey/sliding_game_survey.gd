# main.gd
extends Location

@onready var slider_box = $QuestionWrap/SliderBox
var ASSET_PATH := "res://Assets/knowledge_tests/"
var CASE := "caesr"
#@onready var score_label = $ScoreLabel
#@onready var timer = $Timer

var score: Array[int] = []
var current_question = 0
var questions = []
var startTime : int

func _ready():
	super._ready()
	
	startTime = Time.get_ticks_msec() / 1000.0
	load_questions()
	show_next_question()
	_choose_case()
	slider_box.connect("answer_chosen", Callable(self, "_on_answer_chosen"))


func load_questions():
	var file = FileAccess.open(ASSET_PATH+"survey_questions.json", FileAccess.READ)
	questions = JSON.parse_string(file.get_as_text())

func show_next_question():
	if current_question >= questions.size():
		print(CASE+" Survey done! They chose: ", score)
		Analytics.add_game_survey_analytics(score, (Time.get_ticks_msec() / 1000.0) - startTime)
		var item = Item.new()
		item.item_name = self.location_name + " completed"
		item.is_collectable = false
		item_found.emit(item, self)
	else: slider_box.show_question(questions[current_question])

func _on_answer_chosen(value):
	score.append(int(value)) 
	current_question += 1
	show_next_question()
	
func _choose_case():
	if case!=null:
		CASE = case.case_slug
	else:
		CASE = "pixel"
	ASSET_PATH += (CASE+'/')
