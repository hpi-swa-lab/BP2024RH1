extends Control

enum Value_Type {
	BINARY,
	DECIMAL
}

@onready var h_box_container: HBoxContainer = $HBoxContainer

@export var slot_count: int
@export var value_type: Value_Type = Value_Type.BINARY
@export var correct_code: String

var current_input: Array
var slot_values: Array
var slot_start_index: int
var slots: Array

signal succeeded


func _ready() -> void:
	if not is_correct_code_valid():
		push_error("Please enter a valid Code.")	
		
	build_lock()
	
func build_lock() -> void:
	clear()
	current_input = []
	
	match value_type:
		Value_Type.BINARY:
			slot_values = ["0", "1"]
			slot_start_index = 0
		Value_Type.DECIMAL:
			slot_values = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
			slot_start_index = 2
			
	for i in range(slot_count):
		var slot = load("res://Cases/Binary_Trap/Scenes/Minigames/slot.tscn").instantiate()
		slots.append(slot)
		slot.values = slot_values
		slot.start_index = slot_start_index
		slot.value_changed.connect(_on_slot_changed.bind(i))
		current_input.append(slot.get_value())
		h_box_container.add_child(slot)
	
func _on_slot_changed(index: int) -> void:
	current_input[index] = h_box_container.get_child(index).get_value()
	check_code()
	
func check_code() -> void:
	var input: String = array_to_string(current_input)
	if input == correct_code:
		succeeded.emit()

func array_to_string(array: Array) -> String:
	var string: String = ""
	for i in array:
		string += String(i)
	return string
	
func is_correct_code_valid() -> bool:
	if correct_code.length() != slot_count:
		return false
		
	var allowed_chars: Array = []
	match value_type:
		Value_Type.BINARY:
			allowed_chars = ["0", "1"]
		Value_Type.DECIMAL:
			allowed_chars = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
	
	for character in correct_code:
		if character not in allowed_chars:
			return false
			
	return true
	
func clear() -> void:
	for child in h_box_container.get_children():
		child.queue_free()
		
func set_font_color(color: Color) -> void:
	for slot in slots:
		slot.set_font_color(color)
	
