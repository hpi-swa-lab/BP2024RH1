extends Button

signal display_helpscreen

func _ready() -> void:
	visible = false

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):	
		visible = false
		emit_signal("display_helpscreen")


func _on_timer_timeout() -> void:
	visible = true
