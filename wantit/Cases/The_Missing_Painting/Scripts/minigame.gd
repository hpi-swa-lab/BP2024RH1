extends Location
var columns = 8
var solution = "10100010" + "00000001" + "11100011" + "10100110" + "11100011" + "00000010" + "00100001" + "11001100"
var correct_solution

func add_solution_Grid(Grid: GridContainer):
	for i in range(columns * columns):
		var rect = ColorRect.new()
		rect.custom_minimum_size = Vector2(Grid.size.x / columns, Grid.size.y / columns)
		if solution[i] == "1":
			rect.color = Color(224,224,224)
		elif solution[i] == "0":
			rect.color = Color(0, 0, 0)
		Grid.add_child(rect)

func _on_paper_visibility_changed() -> void:
	%SolutionGrid.columns = columns
	add_solution_Grid(%SolutionGrid)

func _on_game_art_visibility_changed() -> void:
	if %Button.text == "":
		%Button.visible = true
		%Button.text = "Pixeleditor öffnen"
		
func _on_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		correct_solution = true
		if %Button.text == "Pixeleditor öffnen":
			var item = Item.new()
			item.item_name = "got_items"
			item_found.emit(item)
			%GameArt.visible = false
			%RightGrid.columns = columns
			%LeftGrid.columns = columns
			%LeftGrid.visible = true
			#%RightGrid.visible = true
			add_clickable_buttons(%LeftGrid)
			#add_buttons(%RightGrid)
			%Button.position = Vector2(891, 246)
			%Button.text = "Webseite suchen"
			DialogueManager.show_dialogue_balloon(load ("res://Cases/The_Missing_Painting/Dialogue/minigame.dialogue"), "default")
		elif %Button.text == "Webseite suchen":
			var grid_button: Button
			for i in range(%LeftGrid.get_child_count()):
				grid_button = %LeftGrid.get_child(i)
				if grid_button.text != solution[i]:
					correct_solution = false
					%Button.text = "Pixel ändern"
					%Button.position = Vector2(621, 446)
					%LeftGrid.visible = false
					%RightGrid.visible = false
					display_solution()
					return
			%LeftGrid.visible = false
			%RightGrid.visible = false
			display_solution()
			return
		elif %Button.text == "Pixel ändern":
			%Button.position = Vector2(891, 246)
			%Button.text = "Webseite suchen"
			edit_pixels()
			return
	
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
	var button = %LeftGrid.get_child(ButtonPos)
	var rect = %RightGrid.get_child(ButtonPos)
	if button.text == "1":
		#rect.color = Color(0, 0, 0)
		button.text = "0"
	elif button.text == "0":
		#rect.color = Color(1, 1, 1)
		button.text = "1"
		
			
func display_solution():
	%Display.visible = true
	if not correct_solution:
		var cinema = load("res://Cases/The_Missing_Painting/Assets/Minigame/website_cinema.png")
		var plants = load("res://Cases/The_Missing_Painting/Assets/Minigame/website_plants.png")
		var zoo = load("res://Cases/The_Missing_Painting/Assets/Minigame/website_safari.png")
		var displays = [cinema, plants, zoo]
		var random_display = displays[randi() % displays.size()]
		%Display.texture = random_display
		DialogueManager.show_dialogue_balloon(load ("res://Cases/The_Missing_Painting/Dialogue/minigame.dialogue"), "false_solution")
	if correct_solution:
		%Button.visible = false
		%Display.texture = load("res://Cases/The_Missing_Painting/Assets/Minigame/website_galery.png")
		DialogueManager.show_dialogue_balloon(load ("res://Cases/The_Missing_Painting/Dialogue/minigame.dialogue"), "correct_solution")
		

func _on_pixel_editor_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		edit_pixels()
		%Button.visible = true
		DialogueManager.show_dialogue_balloon(load ("res://dialogue/main.dialogue"), "pixeleditor")
		
func edit_pixels():
	#monitor_label.visible = false
	%Display.visible = false
	#pixel_editor.visible = false
	%LeftGrid.visible = true
	#%RightGrid.visible = true
	#if %Button.text == "Webseite suchen":
	#	add_buttons(%RightGrid)
	#	add_clickable_buttons(%LeftGrid)
