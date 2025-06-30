extends Location

const alphabet = "TUVWXYZABCDEFGHIJKLMNOPQRS"
var textfield_index = 0
var text_fields

signal Minigame_completed()

@export var interaction_name: String
@export var original_text: String
@export var shown_text: String

func _ready():
	initialize_disk()
	set_lineEdits()
	set_encrypted_text()
	

func initialize_disk():
	var rot_angle = deg_to_rad(13.84)
	
	for i in range(alphabet.length()):
		var letter = alphabet[i]

		var new_shape = %CollisionPolygon2D.duplicate()
		new_shape.rotation += i * rot_angle

		var clickable_letter = Area2D.new()
		clickable_letter.position = new_shape.position
		clickable_letter.connect("input_event", _on_letter_clicked.bind(letter))

		clickable_letter.add_child(new_shape)
		%Area2D.add_child(clickable_letter)

func set_lineEdits():
		var custom_theme = Theme.new()
		custom_theme.set_constant("minimum_character_width", "LineEdit", 1)
		
		for letter in original_text:
			if letter == " ":
				var spacer = Control.new()
				spacer.custom_minimum_size = Vector2(10, 0)
				%HBoxContainer.add_child(spacer)
			else:
				var field = LineEdit.new()
				field.max_length = 1
				field.placeholder_text = "_"
				%HBoxContainer.add_child(field)
				field.theme = custom_theme
				field.alignment = 1
		text_fields = %HBoxContainer.get_children()
		text_fields[0].grab_focus()

func set_encrypted_text():
	for letter in shown_text:
		if letter == " ":
			var spacer = Control.new()
			spacer.custom_minimum_size = Vector2(10, 0)
			%EncryptedText.add_child(spacer)
		else:
			var label = Label.new()
			label.add_theme_color_override("font_color", Color.BLACK)
			label.text = letter.to_upper()
			label.custom_minimum_size = Vector2(23, 0)
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			%EncryptedText.add_child(label)
		

func _on_letter_clicked(_viewport, event, _shape_idx, letter):
	for i in range(text_fields.size()):
		if text_fields[i] is LineEdit and text_fields[i].has_focus():
			textfield_index = i
			break
	if event is InputEventMouseButton and event.pressed:
		if text_fields[textfield_index] is LineEdit:
			text_fields[textfield_index].text = letter
			text_fields[textfield_index].release_focus()
			if (textfield_index + 1 ) < original_text.length():
				text_fields[textfield_index + 1].grab_focus()
			print(letter)
		else:
			text_fields[textfield_index + 1].grab_focus()

func _on_links_pressed() -> void:
	%Drehen.rotation -= deg_to_rad(13.84)

func _on_rechts_pressed() -> void:
	%Drehen.rotation += deg_to_rad(13.84)

func _on_check_solution_pressed() -> void:
	var input_text: String = ""
	for i in range(text_fields.size()):
		if text_fields[i] is LineEdit:
			input_text += text_fields[i].text
		else:
			input_text += " "
	if input_text == original_text.to_upper():
		if location_dialogue:
			DialogueManager.show_dialogue_balloon_scene(
				location_dialogue.baloon_type,
				location_dialogue.dialogue_resource,
				"minigame_completed")
			await DialogueManager.dialogue_ended
				
		var interaction_item = Item.new()
		interaction_item.item_name = interaction_name
		item_found.emit(interaction_item)
