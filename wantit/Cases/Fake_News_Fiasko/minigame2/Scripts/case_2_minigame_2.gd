extends Location

var selected_statement: Control
var statement_count: int

var true_statements = []
var wrong_conc_statements = []
var exagerated_statements = []
var generelized_statements = []

func _ready() -> void:
	for evidence in %Evidence.get_children():
		evidence.evidence_inspected.connect(_on_evidence_inspected)
	for statement in %Statements.get_children():
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
	for statement in %Statements.get_children():
		statement.update_highlight(false)
	selected_statement = new_statement

func _on_true_pressed() -> void:
	add_statement_to_array(true_statements)

func _on_wrong_conclusion_pressed() -> void:
	add_statement_to_array(wrong_conc_statements)

func _on_generalazation_pressed() -> void:
	add_statement_to_array(generelized_statements)

func _on_exageration_pressed() -> void:
	add_statement_to_array(exagerated_statements)

func add_statement_to_array(array: Array):
	if statement_count == 5:
		selected_statement.hide()
		%Wrong_conclusion.hide()
		%Generalazation.hide()
		%Exageration.hide()
		%True.text = "Überprüfen"
	elif statement_count < 5:
		if selected_statement != null:
			array.append(selected_statement)
			selected_statement.hide()
			statement_count += 1
			selected_statement = null
	else:
		if check_solution():
			print("nice") # Dialogue and scene switching
		else:
			retry_level()

func check_solution() -> bool:
	for statement in %Statements.get_children():
		match statement.Category:
			0: return statement in true_statements
			1: return statement in wrong_conc_statements
			2: return statement in generelized_statements
			3: return statement in exagerated_statements
	return true

func retry_level():
	pass
