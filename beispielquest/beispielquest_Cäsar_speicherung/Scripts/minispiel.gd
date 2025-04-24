extends Node2D

const alphabet = "TUVWXYZABCDEFGHIJKLMNOPQRS"
var textfield_index = 0
var text_fields

@export var original_text = "BITSTOP ZEHN UHR" # Muss in Großbuchtaben geschrieben werden
@export var shown_text = " F M  X W  X  S  T    D   I  L  R     Y  L  V"
@onready var input_container = %HBoxContainer
@onready var hinweis: Label = $Hinweis


func _ready():
	hinweis.hide()
	
	Global.last_visited_scene = "res://Scenes/minispiel.tscn"
	GameSaver.save_game()
	
	if Global.verschiebung_found:
		hinweis.show()
	
	%"VerschlüsselterText".text = shown_text
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
	
	var custom_theme = Theme.new()
	custom_theme.set_constant("minimum_character_width", "LineEdit", 1)
	
	
	for char in original_text:
		if char == " ":
			var spacer = Control.new()
			spacer.custom_minimum_size = Vector2(10, 0)
			input_container.add_child(spacer)
		else:
			var field = LineEdit.new()
			field.max_length = 1
			field.placeholder_text = "_"
			input_container.add_child(field)
			field.theme = custom_theme
			field.alignment = 1
	text_fields = %HBoxContainer.get_children()
	text_fields[0].grab_focus()

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
	var input_text:String
	for i in range(text_fields.size()):
		if text_fields[i] is LineEdit:
			input_text += text_fields[i].text
		else:
			input_text += " "
	if input_text == original_text:
		print("congrats")
		Global.caesar_decrypted = true
