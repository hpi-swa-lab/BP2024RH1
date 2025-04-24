extends Node2D

var textfield_index = 0
var text_fields
var new_alphabet: String
var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

const RADIUS_INNER := 118

@export var original_text = "GEHEIMES GEHEIMNIS" # Muss in Großbuchtaben geschrieben werden
@export var shown_text = "H  B   I  B   J  M B  S    H  B   I  B   J  M  N  J  S"
@onready var input_container = %HBoxContainer
@onready var schlüsselwort: LineEdit = %Schlüsselwort
@onready var bella: Button = %Bella

func _ready():
	bella.disabled
	bella.hide()
	DialogueManager.show_dialogue_balloon(load("res://dialogues/Caesar2.dialogue"), "start")
	%VerschlüsselterText.text = shown_text
	
	create_inner_circle()
	
	# Custom Theme erzeugen, damit die Textboxen kleiner werden
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

func _process(_delta: float) -> void:
	if Global.schluesselwort_found:
		bella.show()
		
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

func _on_check_solution_pressed() -> void:
	var input_text:String
	for i in range(text_fields.size()):
		if text_fields[i] is LineEdit:
			input_text += text_fields[i].text
		else:
			input_text += " "
	if input_text == original_text:
		print("congrats")
		DialogueManager.show_dialogue_balloon(load("res://dialogues/Caesar2.dialogue"), "fertig")

func remove_duplicates(new_text: String, old_text: String) -> String:
	for char in new_text:
		if not char in old_text:
			old_text += char
	return old_text

func create_inner_circle() -> void:
	remove_children(%Area2D)
	remove_children(%InnerRing)
	#print(%Area2D.get_children())
	for i in range(new_alphabet.length()):
		var angle = i * deg_to_rad((360.0 / new_alphabet.length())) - deg_to_rad(97)
		var label = Label.new()
		var letter = new_alphabet[i]
		label.add_theme_color_override("font_color", Color(0, 0, 0))
		label.text = letter
		label.set_position(Vector2(cos(angle), sin(angle)) * RADIUS_INNER)
		label.set_pivot_offset(label.get_size() / 2.0)
		label.rotation = angle + PI/2  # Optional: für "stehende" Buchstaben
		%InnerRing.add_child(label)
		
		var new_shape = %CollisionPolygon2D.duplicate()
		new_shape.rotation += angle

		var clickable_letter = Area2D.new()
		clickable_letter.position = new_shape.position
		clickable_letter.connect("input_event", _on_letter_clicked.bind(letter))

		clickable_letter.add_child(new_shape)
		%Area2D.add_child(clickable_letter)

func _on_apply_inner_pressed() -> void:
	new_alphabet = remove_duplicates(%Schlüsselwort.text.to_upper(), "")
	new_alphabet = remove_duplicates(alphabet, new_alphabet)
	create_inner_circle()
	text_fields[0].grab_focus()

func remove_children(node: Node):
	for child in node.get_children():
		if not child is CollisionPolygon2D:
			node.remove_child(child)
			child.queue_free()

func end_it() -> void:
	SceneSwitcher.switch_scene("res://Scenes/ende.tscn")


func _on_keyword_clicked(text: String) -> void:
	schlüsselwort.text = text
