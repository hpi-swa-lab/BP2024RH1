extends Node2D

var columns = 8
var solution = "11111111" + "11111111" + "10011111" + "00000000" + "00001101" + "10011111" + "11111111" + "11111111"
var correct_solution = true

func _ready() -> void:
	if solution.length() != columns * columns:
		print("sour solution does not have the right length", solution.length())
	%RightGrid.columns = columns
	%LeftGrid.columns = columns
	%SolutionGrid.columns = columns
	add_buttons(%LeftGrid)
	add_clickable_buttons(%RightGrid)
	add_solution_Grid(%SolutionGrid)
	
func add_solution_Grid(Grid: GridContainer):
	for i in range(columns * columns):
		var rect = ColorRect.new()
		rect.custom_minimum_size = Vector2(Grid.size.x / columns, Grid.size.y / columns)
		if solution[i] == "1":
			rect.color = Color8(224,224,224)
		elif solution[i] == "0":
			rect.color = Color(0, 0, 0)
		Grid.add_child(rect)
	
func add_buttons(Grid: GridContainer):
	for i in range(columns * columns):
		var rect = ColorRect.new()
		rect.custom_minimum_size = Vector2(Grid.size.x / columns, Grid.size.y / columns)
		rect.color = Color8(224,224,224)
		Grid.add_child(rect)

func add_clickable_buttons(Grid: GridContainer):
	for i in range(columns * columns):
		var button = Button.new()
		button.text = "1"
		button.clip_text = true
		button.custom_minimum_size = Vector2(Grid.size.x / columns, Grid.size.y / columns)
		button.pressed.connect(self._button_pressed.bind(i))
		Grid.add_child(button)

func _button_pressed(ButtonPos: int):
	var button = %RightGrid.get_child(ButtonPos)
	var rect = %LeftGrid.get_child(ButtonPos)
	if button.text == "1":
		rect.color = Color(0, 0, 0)
		button.text = "0"
	elif button.text == "0":
		rect.color = Color8(224, 224, 224)
		button.text = "1"
	else:
		print("There are some very wrong values here")
	


func _on_check_solution_pressed() -> void:
	var button: Button
	for i in range(%RightGrid.get_child_count()):
		button = %RightGrid.get_child(i)
		if button.text != solution[i]:
			correct_solution = false
			%Label.visible = true
			break
	if correct_solution == true:
		print("well Done")
		%Label.visible = false
	correct_solution = true
