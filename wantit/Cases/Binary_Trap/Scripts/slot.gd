extends Control

@onready var label: Label = $VBoxContainer/Label

@export var values: Array
@export var start_index: int = 0 #Use 0 as default index


var current_index: int = 0:
	set(value):
		current_index = (value + values.size()) % values.size()
		update_display()

var upper_bound: int = values.size() - 1
var lower_bound: int = 0

signal value_changed


func _ready() -> void:
	current_index = start_index
	update_display()
	
func update_display() -> void:
	label.text = values[current_index]

func _on_button_up_pressed() -> void:
	current_index += 1
	value_changed.emit()

func _on_button_down_pressed() -> void:
	current_index -= 1
	value_changed.emit()
	
func get_value() -> String:
	return values[current_index]
	
func set_font_color(color: Color) -> void:
	label.add_theme_color_override("font_color", color)
