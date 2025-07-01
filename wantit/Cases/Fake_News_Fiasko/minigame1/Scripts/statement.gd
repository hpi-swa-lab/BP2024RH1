extends Control

@export_enum("Wahr", "Falsch") var category

signal statement_selected(statement: Control)
var highlight: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		statement_selected.emit(self)
		update_highlight(true)

func _draw():
	if highlight:
		draw_rect(Rect2(Vector2.ZERO, size), Color.WEB_GRAY, false, 2)

func update_highlight(new_highlight: bool):
	highlight = new_highlight
	queue_redraw()
