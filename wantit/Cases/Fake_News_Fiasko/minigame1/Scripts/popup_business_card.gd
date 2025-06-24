extends Control

@onready var pic = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not pic.get_global_rect().has_point(event.position):
			visible = false


func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		visible = true
