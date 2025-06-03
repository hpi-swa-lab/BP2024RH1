extends Control

signal display_question_mark

@onready var hint_text = $MarginContainer/Hint_text

 
func _ready() -> void:
	visible = false

func set_hint_text(text: String) -> void:
	hint_text.text = text

func _on_close_btn_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton: #is_action_pressed("left_click"):
		visible = false
		emit_signal("display_question_mark")
	# delay until helpscreen can be used again (einblenden or disable) emit signal
		print("close_btn") 
