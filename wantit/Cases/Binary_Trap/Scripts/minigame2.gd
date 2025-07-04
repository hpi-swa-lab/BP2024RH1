extends Control

@onready var input_label: Label = $"Input Label"
@onready var result_label: Label = $"Result Label"
@onready var lamps: Array = [$"HBoxContainer/Lamp and Switch", $"HBoxContainer/Lamp and Switch2", $"HBoxContainer/Lamp and Switch3", $"HBoxContainer/Lamp and Switch4"]

const weights: Array = [8, 4, 2, 1]
const lamp_count: int = 4

func _ready() -> void:
	randomize()
	input_label.text = generate_binary_string(lamp_count)
	
	lamps[lamp_count - 1].operation_label.text = "="
	
	for i in range(0, lamps.size()):
		lamps[i].weight = weights[i]
		lamps[i].connect("updated", self.update_result)
		
func update_result() -> void:
	var total: int = 0
	for lamp in lamps:
		total += lamp.get_value()
	
	check_output(total)
	result_label.text = str(total)
	
func check_output(result: int) -> void:
	var input = input_label.text
	var output = convert_decimal_to_binary(result)
	
	var differnce: int = lamp_count - output.length()
	if differnce > 0:
		output = "0".repeat(differnce) + output
	
	if output == input:
		result_label.add_theme_color_override("font_color", Color.LIME_GREEN)
	else:
		result_label.add_theme_color_override("font_color", Color.RED)

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
	
func convert_decimal_to_binary(decimal: int) -> String:
	var binary_string = ""
	var number = decimal
	
	if number == 0:
		return "0"
	
	while number > 0:
		binary_string = str(number % 2) + binary_string
		number = number / 2
	
	return binary_string
