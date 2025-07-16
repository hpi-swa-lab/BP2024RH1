extends Minigame

var original_text = "BEI SR ZU -I"
var solution_text = "GIB ES ZU -B"
var text_fields: Array
var new_text: String = ""
var correct_encrypted_alphabet = "picasobdefghjklmnqrtuvwxyz"

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
		field.text_changed.connect(func(int): _on_text_changed(i))
		
		var spacer = Control.new()
		spacer.custom_minimum_size = Vector2(4.5, 0)
		%HBoxContainer.add_child(spacer)
		
	for child in %HBoxContainer.get_children():
		if child is LineEdit:
			text_fields.append(child)

func apply_solution() -> bool:
	const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	var encrypted_alphabet: String = ""
	
	for child in text_fields:
		if child.text.to_upper() not in encrypted_alphabet:
			encrypted_alphabet += child.text.to_upper()
		else:
			start_dialogue("double_letter")
			return false
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
	await get_tree().process_frame
	await get_tree().process_frame
	
	%ColorRect.size = %DecryptedMessage.size
	
	return encrypted_alphabet.to_lower() == correct_encrypted_alphabet

func _on_button_pressed() -> void:
	if await apply_solution():
		start_dialogue("correct_solution")
	else:
		start_dialogue("wrong_solution")
		reset()

func reset():
	%DecryptedMessage.text = ""
	for child in text_fields:
		child.text = ""

func _on_text_changed(field_num: int):
	if field_num + 1 <= text_fields.size() - 1 and text_fields[field_num].text != "":
		text_fields[field_num + 1].grab_focus()

func start_dialogue(dialogue_start: String):
	DialogueManager.show_dialogue_balloon_scene(
			location_dialogue.dialogue_baloon_path,
			location_dialogue.dialogue_resource,
			dialogue_start)
	await DialogueManager.dialogue_ended
