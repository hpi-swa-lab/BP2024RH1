extends VBoxContainer

@onready var question_label: Label = $QuestionLabel
@onready var answer_buttons: Array = [$A1, $A2, $A3, $A4]
@onready var answer_box: TextEdit = $ABox
@onready var answer_submit: Button = $ASubmit
@onready var question_image: TextureRect = $QuestionImage
@export var ASSET_PATH: String


signal answer_chosen(correct: bool)
signal text_answer_submitted(text: String)

func _ready():
	answer_submit.pressed.connect(_on_submit_pressed)
	for i in range(4):
		var btn = answer_buttons[i]
		btn.connect("answer_selected", Callable(self, "_on_answer_selected"))

func show_question(q: Dictionary):
	answer_submit.visible = false
	answer_box.visible = false
	question_label.text = q["question"]
	answer_box.clear()

	# Show or hide image
	if q.has("image") and q["image"] != "":
		var image_path = ASSET_PATH+q["image"]
		var texture = load(image_path)
		if texture:
			question_image.texture = texture
			question_image.visible = true
		else:
			question_image.visible = false
	else:
		question_image.visible = false
	
	if q.has("isWrite"):
		answer_box.visible = true
		answer_submit.visible = true
		
		

	# Setup answer buttons
	for i in range(4):
		var btn = answer_buttons[i]
		btn.visible = true
		btn.text = q["answers"][i]
		if btn.text == "":
			btn.visible = false
		btn.is_correct = (i == q["correct"])


func _on_answer_selected(correct: bool):
	answer_chosen.emit(correct)
	
func _on_submit_pressed():
	var answer = answer_box.text
	if answer != "":
		text_answer_submitted.emit(answer)
	
