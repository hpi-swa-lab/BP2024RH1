extends Location

var original_text = "BEI SR ZU -I"
var solution_text = "GIB ES ZU -B"
var text_fields: Array

func _ready() -> void:
	super._ready()
	
	initialize_alphabet()

func initialize_alphabet():
	for i in range(26):
		var custom_theme = Theme.new()
		custom_theme.set_constant("minimum_character_width", "LineEdit", 1)
		var field = LineEdit.new()
		field.max_length = 1
		field.placeholder_text = "_"
		%HBoxContainer.add_child(field)
		field.theme = custom_theme
		field.alignment = 1
		field.text_changed.connect(func(int): _on_text_changed(i+1))
		
		var spacer = Control.new()
		spacer.custom_minimum_size = Vector2(4.5, 0)
		%HBoxContainer.add_child(spacer)
		
	for child in %HBoxContainer.get_children():
		if child is LineEdit:
			text_fields.append(child)

func apply_solution() -> bool:
	const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	var new_text: String = ""
	var encrypted_alphabet: String = ""
	
	for child in text_fields:
		if child.text.to_upper() not in encrypted_alphabet:
			encrypted_alphabet += child.text.to_upper()
		else:
			start_dialogue("double_letters")
	if encrypted_alphabet.length() != alphabet.length():
		start_dialogue("not_whole_alphabet")
	else:
		for i in original_text.length():
			var letter = original_text[i]
			if encrypted_alphabet.contains(letter):
				new_text += alphabet[encrypted_alphabet.find(letter)]
			elif letter == " " or letter == "-":
				new_text += letter
	%DecryptedMessage.text = new_text
	%ColorRect.size = %DecryptedMessage.size
	%ColorRect.position = %DecryptedMessage.position
	
	return new_text == solution_text

func _on_button_pressed() -> void:
	if apply_solution():
		start_dialogue("correct_solution")
	else:
		start_dialogue("wrong_solution")
		#reset()

func reset():
	%DecryptedMessage.text = ""
	for child in text_fields:
		child.text = ""

func _on_text_changed(field_num: int):
	if field_num <= text_fields.size()-1:
		text_fields[field_num].grab_focus()

func start_dialogue(dialogue_start: String):
	DialogueManager.show_dialogue_balloon_scene(
			location_dialogue.dialogue_baloon_path,
			location_dialogue.dialogue_resource,
			dialogue_start)
	await DialogueManager.dialogue_ended
