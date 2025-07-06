extends Control

@onready var input_label: Label = $"Input Label"
@onready var gap_game: Control = $"Gap Game"

const gap_number: int = 4
var input: String

func _ready() -> void:
	gap_game.set_font_color(Color.BLACK)
	randomize()
	input = generate_binary_string(gap_number)		
	input_label.text = input
	
func generate_binary_string(length: int) -> String:
	var characters: String = "01"
	var binary_string: String
	var n_char: int = len(characters)
	
	while true:
		binary_string = ""
		for i in range(length):
			binary_string += characters[randi()% n_char]
			
		var count_ones = 0
		for character in binary_string:
			if character == "1":
				count_ones += 1
			
		if count_ones >= 2:
			break
	
	return binary_string	

func check_output(result: int) -> void:
	var output = convert_decimal_to_binary(result)
	
	var differnce: int = gap_number - output.length()
	if differnce > 0:
		output = "0".repeat(differnce) + output
	
	if output == input:
		if gap_game:
			gap_game.set_result_color(Color.LIME_GREEN)
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

func _on_gap_game_updated(result: int) -> void:
	check_output(result)
	
