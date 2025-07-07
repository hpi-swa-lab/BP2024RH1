extends Control

@onready var input_label: Label = $"Input Label"
@onready var gap_game: Control = $"Gap Game"
@onready var binary_label: Label = $"Binary Label"
@onready var label_2: Label = $Label2
@onready var texture_rect_2: TextureRect = $TextureRect2
@onready var restart_button: Button = $"Restart Button"
@onready var back_button: LocationSwitchButton = $"../BackButton"

const gap_number: int = 4
var input: int

func _ready() -> void:
	randomize()
	refresh()
	
func _enter_tree() -> void:
	await get_tree().process_frame
	set_back_button_location(get_parent().case.from_location)
	
func generate_integer() -> int:
	return randi_range(1,15)	

func check_output(result: int) -> void:
	if gap_game:
		binary_label.text = ""
		label_2.hide()
		texture_rect_2.hide()
	
	if result == input:
		if gap_game:
			gap_game.set_result_color(Color.LIME_GREEN)
			label_2.show()
			texture_rect_2.show()
			binary_label.text = pad_with_zeros(convert_decimal_to_binary(input))
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
	
func pad_with_zeros(binary: String) -> String:
	var differnce: int = gap_number - binary.length()
	if differnce > 0:
		binary = "0".repeat(differnce) + binary
	
	return binary

func _on_gap_game_updated(result: int) -> void:
	check_output(result)
	
func refresh() -> void:
	restart_button.hide()
	
	label_2.hide()
	texture_rect_2.hide()
	
	binary_label.text = ""
	
	input = generate_integer()		
	input_label.text = str(input)
	
	gap_game.refresh()
	
func _on_restart_button_pressed() -> void:
	refresh()
	
func set_back_button_location(location: String) -> void:
	back_button.change_requested_location(location)
