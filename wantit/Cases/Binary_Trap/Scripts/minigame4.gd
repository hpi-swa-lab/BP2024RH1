extends Control

@onready var input_label: Label = $"Input Label"
@onready var gap_game: Control = $"Gap Game"
@onready var binary_label: Label = $"Binary Label"

const gap_number: int = 4
var input: int

func _ready() -> void:
	randomize()
	input = generate_integer()		
	input_label.text = str(input)
	
func generate_integer() -> int:
	return randi_range(5,15)	

func check_output(result: int) -> void:
	if gap_game:
		binary_label.text = ""
	
	if result == input:
		if gap_game:
			gap_game.set_result_color(Color.LIME_GREEN)
			binary_label.text = pad_with_zeros(convert_decimal_to_binary(input))
	else:
		if gap_game:
			gap_game.set_result_color(Color.RED)	
		
func convert_decimal_to_binary(decimal: int) -> String:
	var binary_string = ""
	var number = decimal
	
	if number == 0:
		return "0"
	
	while number > 0:
		binary_string = str(number % 2) + binary_string
		number = number / 2
	
	return binary_string
	
func pad_with_zeros(binary: String) -> String:
	var differnce: int = gap_number - binary.length()
	if differnce > 0:
		binary = "0".repeat(differnce) + binary
	
	return binary

func _on_gap_game_updated(result: int) -> void:
	check_output(result)
