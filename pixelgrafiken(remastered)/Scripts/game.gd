extends Node2D

var columns = 8
var solution = "11111111" + "11111111" + "10011111" + "00000000" + "00001101" + "10011111" + "11111111" + "11111111"
var correct_solution = true

func _ready() -> void:
	if Global.Options == 1:
		solution = "11111111" + "11111111" + "10011111" + "00000000" + "00001101" + "10011111" + "11111111" + "11111111"
		%CheckSolution.text = "Drucken"
	else: 
		solution = "10100010" + "00000001" + "11100011" + "10100110" + "11100011" + "00000010" + "00100001" + "11001100"
		%CheckSolution.text = "QR-Code erstellen"
		
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
			rect.color = Color(224,224,224)
		elif solution[i] == "0":
			rect.color = Color(0, 0, 0)
		Grid.add_child(rect)
	
func add_buttons(Grid: GridContainer):
	for i in range(columns * columns):
		var rect = ColorRect.new()
		rect.custom_minimum_size = Vector2(Grid.size.x / columns, Grid.size.y / columns)
		rect.color = Color(1,1,1)
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
		rect.color = Color(1, 1, 1)
		button.text = "1"
	else:
		print("There are some very wrong values here")

func create_image(Grid: GridContainer) -> ImageTexture:
	var size := Grid.columns
	var Img := Image.create(size, size, false, Image.FORMAT_RGB8)

	for y in range(size):
		for x in range(size): 
			var index = y * size + x
			var child = Grid.get_child(index)
			if child is ColorRect:
				Img.set_pixel(x, y, child.color)
	
	var scale_factor := 12.25
	Img.resize(size * scale_factor, size * scale_factor, Image.INTERPOLATE_NEAREST)
	
	var tex = ImageTexture.create_from_image(Img)
	return tex
	
func _on_check_solution_pressed() -> void:
	if Global.Options == 1:
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
	else:
		var texture = create_image(%LeftGrid)
		Global.Tex = texture
		SceneSwitcher.switch_scene("res://Scenes/printing.tscn")
