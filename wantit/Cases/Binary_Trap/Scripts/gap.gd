extends Control

@onready var option_button: OptionButton = $VBoxContainer/OptionButton
@onready var operation_label: Label = $"VBoxContainer/Operation Label"
@onready var weight_label: Label = $"VBoxContainer/Weight Label"

signal value_changed
var weight: int

func _ready() -> void:
	option_button.clear()
	option_button.add_item("0", 0)
	option_button.add_item("1", 1)

func _on_option_button_item_selected(_index: int) -> void:
	value_changed.emit()
	
func get_value() -> int:
	return option_button.get_selected_id() * weight
	
func set_weight() -> void:
	weight_label.text = str(weight)
