extends VBoxContainer

@onready var slider = $Scale/OpinionSlider
@onready var color_vibe = $VibeContainer/ColorVibe
@onready var textual_vibe = $VibeContainer/TextualVibe
@onready var question_label: Label = $QuestionLabel
@onready var submit_btn = $SubmitButtonContainer/SubmitButton

# Define vibe states
var vibes = [
	{ "color": Color("#eb595a"), "text": "Stimme gar nicht zu" },
	{ "color": Color("#e08a4d"), "text": "Stimme nicht zu" },
	{ "color": Color("#f29e57"), "text": "Stimme eher nicht zu" },
	{ "color": Color("#efe158"), "text": "Neutral" },
	{ "color": Color("#bbd154"), "text": "Stimme eher zu" },
	{ "color": Color("#95d54a"), "text": "Stimme zu" },
	{ "color": Color("#5bac30"), "text": "Stimme voll zu" }
]

signal answer_chosen(value: int)

func _ready():
	slider.min_value = 0
	slider.max_value = vibes.size() - 1
	slider.step = 1
	slider.value = 2  # Start at neutral
	update_vibe(slider.value)
	submit_btn.connect("pressed", Callable(self, "_on_answer_selected"))
	slider.connect("value_changed", _on_slider_value_changed)

func _on_slider_value_changed(value):
	update_vibe(int(value))

func update_vibe(index):
	print("A")
	var vibe = vibes[index]
	color_vibe.color = vibe.color  # Works if it's a ColorRect
	textual_vibe.text = vibe.text
	slider.add_theme_color_override("grabber",vibe.color)
	

func show_question(q: Dictionary):
	question_label.text = q["question"]
	

func _on_answer_selected():
	answer_chosen.emit(slider.value)
