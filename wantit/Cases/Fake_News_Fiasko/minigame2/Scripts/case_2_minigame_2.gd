extends Location

var selected_statement: Control
var statement_count: int = 6
var correct_selection: bool = true
var statements: Array

var categorized_statements = {}
var wrong_categorized_statement = []

func _ready() -> void:
	statements = %Statements.get_children()
	
	for evidence in %Evidence.get_children():
		evidence.evidence_inspected.connect(_on_evidence_inspected)
	for statement in statements:
		statement.statement_selected.connect(_on_statement_selected)

func _on_evidence_inspected(Texture1: Texture2D, Texture2: Texture2D):
	%TextureRect2.custom_minimum_size = Vector2(474, 448) # not nice but %TextureRect2.size_flags_horizontal = Control.SIZE_EXPAND somehow does not work
	
	if Texture1 != null and Texture2 != null:
		%TextureRect.texture = Texture1
		%TextureRect2.texture = Texture2
	elif Texture1 != null or Texture2 != null:
		%TextureRect2.custom_minimum_size = Vector2(0, 0) #same as before
		%TextureRect.texture = Texture1 if Texture1 != null else Texture2
	%HBoxContainer.show()

func _on_h_box_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		%HBoxContainer.hide()

func _on_statement_selected(new_statement: Control):
	for statement in statements:
		statement.update_highlight(false)
	selected_statement = new_statement

func _on_true_pressed() -> void:
	add_statement_to_array(0)

func _on_wrong_conclusion_pressed() -> void:
	add_statement_to_array(1)

func _on_generalization_pressed() -> void:
	add_statement_to_array(2)

func _on_exageration_pressed() -> void:
	add_statement_to_array(3)

func add_statement_to_array(category_value: int):
	check_statement_count()
	if selected_statement != null:
		categorized_statements[selected_statement] = category_value
		selected_statement.hide()
		selected_statement = null
		statement_count -= 1

func check_solution() -> bool:
	for statement in statements:
		if categorized_statements[statement] != statement.category:
			correct_selection = false
			wrong_categorized_statement.append(statement)
	return correct_selection

func retry_level():
	%Wrong_conclusion.show()
	%Generalization.show()
	%Exageration.show()
	%True.text = "Wahr"
	statement_count = 0
	correct_selection = true
	selected_statement = null
	for statement in wrong_categorized_statement:
		statement.show()
		statement_count += 1
	wrong_categorized_statement = []

func check_statement_count():
	if statement_count == 1:
		%Wrong_conclusion.hide()
		%Generalization.hide()
		%Exageration.hide()
		%True.text = "Überprüfen"
	elif statement_count == 0:
		if check_solution():
			print("nice") # Dialogue and scene switching
		else:
			retry_level()
