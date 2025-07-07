extends Minigame

var selected_statement: Control
var correct_selection: bool = true
var statements: Array
var checking: bool = false

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
	if selected_statement != null:
		categorized_statements[selected_statement] = category_value
		selected_statement.hide()
		selected_statement = null
	check_statement_count()

func check_solution() -> bool:
	var correct_selections = 0
	for statement in statements:
		if categorized_statements[statement] != statement.category:
			correct_selection = false
			wrong_categorized_statement.append(statement)
			categorized_statements.erase(statement)
		else:
			correct_selections += 1
	if not correct_selection:
		add_attempt(correct_selections, categorized_statements.size()-correct_selections)
	return correct_selection

func retry_level():
	%Wrong_conclusion.show()
	%Generalization.show()
	%Exageration.show()
	%True.text = "Wahr"
	correct_selection = true
	selected_statement = null
	for statement in wrong_categorized_statement:
		statement.show()
	wrong_categorized_statement = []
	checking = false

func check_statement_count():
	if checking:
		if check_solution():
			DialogueManager.show_dialogue_balloon_scene(
			location_dialogue.baloon_type,
			location_dialogue.dialogue_resource,
			"minigame_completed")
		else:
			retry_level()
	
	if statements.size() == (categorized_statements.size()):
		%Wrong_conclusion.hide()
		%Generalization.hide()
		%Exageration.hide()
		%True.text = "Überprüfen"
		checking = true
