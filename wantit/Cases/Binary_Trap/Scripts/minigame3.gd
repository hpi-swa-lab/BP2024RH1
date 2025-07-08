extends Control

@onready var input_label: Label = $"Input Label"
@onready var gap_game: Control = $"Gap Game"
@onready var restart_button: Button = $"Restart Button"
@onready var back_button: LocationSwitchButton = $"../BackButton"

const gap_number: int = 4
var input: String

func _ready() -> void:
	randomize()
	refresh()
	
func _enter_tree() -> void:
	await get_tree().process_frame
	set_back_button_location(get_parent().case.from_location)
	
func generate_binary_string(length: int) -> String:
	var characters := "01"
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
			
		if count_ones >= 1:
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
			restart_button.show()
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

func refresh() -> void:
	input = generate_binary_string(gap_number)		
	input_label.text = input
	gap_game.refresh()
	gap_game.set_font_color(Color.BLACK)

func _on_restart_button_pressed() -> void:
	restart_button.hide()
	refresh()
	
func set_back_button_location(location: String) -> void:
	back_button.change_requested_location(location)
	
