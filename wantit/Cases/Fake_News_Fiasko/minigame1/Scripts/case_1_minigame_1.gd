extends Minigame

var selected_statement: Control
var statement_count: int = 5
var correct_selection: bool = true
var statements: Array


var categorized_statements = {}
var wrong_categorized_statement = []

func _ready() -> void:
	%Check.hide()
	statements = %Statements.get_children()
	
	for statement in statements:
		statement.statement_selected.connect(_on_statement_selected)
	self.START("fnf_1", statement_count)


func _on_statement_selected(new_statement: Control):
	for statement in statements:
		statement.update_highlight(false)
	selected_statement = new_statement

func _on_false_button_pressed() -> void:
	add_statement_to_array(1)


func _on_true_button_pressed() -> void:
	add_statement_to_array(0)


func add_statement_to_array(category_value: int):
	if selected_statement != null:
		categorized_statements[selected_statement] = category_value
		selected_statement.hide()
		selected_statement = null
		statement_count -= 1
	check_statement_count()

func check_statement_count():
	if statement_count == 0:
		%Check.show()


func _on_check_pressed() -> void:
	if check_solution():
		self.END()
		
		DialogueManager.show_dialogue_balloon_scene(
			location_dialogue.baloon_type,
			location_dialogue.dialogue_resource,
			"minigame_completed")
		await DialogueManager.dialogue_ended
		
		var interaction_item = Item.new()
		interaction_item.item_name = "Minigame1 completed"
		item_found.emit(interaction_item)
	else:
		retry_level()

func check_solution() -> bool:
	for statement in statements:
		if categorized_statements[statement] != statement.category:
			correct_selection = false
			wrong_categorized_statement.append(statement)
	self.TRY(wrong_categorized_statement.size())
	return correct_selection

func retry_level():
	%Check.hide()
	statement_count = 0
	correct_selection = true
	selected_statement = null
	for statement in wrong_categorized_statement:
		statement.show()
		statement_count += 1
	wrong_categorized_statement = []
