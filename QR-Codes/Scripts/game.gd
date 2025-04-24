extends Node2D

@export var card: ColorRect
@export var qrcode: Sprite2D
@export var monitor_label: Label
@export var pixel_editor: Button
@export var button: Button
@export var display: Sprite2D
@export var button_label: Label

var columns: int = 8
var solution: String = "10100010" + "00000001" + "11100011" + "10100110" + "11100011" + "00000010" + "00100001" + "11001100"
var correct_solution: bool = true

func _ready() -> void:
	randomize()
	#if Global.Options == 1:
	#	solution = "11111111" + "11111111" + "10011111" + "00000000" + "00001101" + "10011111" + "11111111" + "11111111"
	#	%CheckSolution.text = "Drucken"
	#else: 
	#	solution = "10100010" + "00000001" + "11100011" + "10100110" + "11100011" + "00000010" + "00100001" + "11001100"
	#	%CheckSolution.text = "QR-Code erstellen"
		
	#if solution.length() != columns * columns:
	#	print("your solution does not have the right length", solution.length())
	%RightGrid.columns = columns
	%LeftGrid.columns = columns
	%SolutionGrid.columns = columns
	add_solution_Grid(%SolutionGrid)
	#add_buttons(%LeftGrid)
	#add_clickable_buttons(%RightGrid)
	#add_solution_Grid(%SolutionGrid)
	
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
	var button = %LeftGrid.get_child(ButtonPos)
	var rect = %RightGrid.get_child(ButtonPos)
	if button.text == "1":
		rect.color = Color(0, 0, 0)
		button.text = "0"
	elif button.text == "0":
		rect.color = Color(1, 1, 1)
		button.text = "1"
	else:
		print("There are some very wrong values here")

#func create_image(Grid: GridContainer) -> ImageTexture:
	#var size := Grid.columns
	#var Img := Image.create(size, size, false, Image.FORMAT_RGB8)
#
	#for y in range(size):
		#for x in range(size): 
			#var index = y * size + x
			#var child = Grid.get_child(index)
			#if child is ColorRect:
				#Img.set_pixel(x, y, child.color)
	#
	#var scale_factor := 12.25
	#Img.resize(size * scale_factor, size * scale_factor, Image.INTERPOLATE_NEAREST)
	#
	#var tex = ImageTexture.create_from_image(Img)
	#return tex
	
#func _on_check_solution_pressed() -> void:
	#if Global.Options == 1:
		#var button: Button
		#for i in range(%RightGrid.get_child_count()):
			#button = %RightGrid.get_child(i)
			#if button.text != solution[i]:
				#correct_solution = false
				#%Label.visible = true
				#break
		#if correct_solution == true:
			#print("well Done")
			#%Label.visible = false
		#correct_solution = true
	#else:
		##var texture = create_image(%LeftGrid)
		##Global.Tex = texture
		#SceneSwitcher.switch_scene("res://Scenes/printing.tscn")


func _on_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		correct_solution = true
		if button_label.text == "Karte einscannen":
			card.visible = true
			await get_tree().create_timer(2).timeout
			card.visible = false
			qrcode.visible = true
			monitor_label.text = "QR-Code unvollständig"
			pixel_editor.visible = true
			button_label.text = "Webseite suchen"
			return
		elif button_label.text == "Webseite suchen":
			var grid_button: Button
			for i in range(%LeftGrid.get_child_count()):
				grid_button = %LeftGrid.get_child(i)
				if grid_button.text != solution[i]:
					display.visible = true
					correct_solution = false
					button_label.text = "Pixel ändern"
					%LeftGrid.visible = false
					%RightGrid.visible = false
					display_solution()
					return
			display.visible = true
			%LeftGrid.visible = false
			%RightGrid.visible = false
			display_solution()
			return
		elif button_label.text == "Pixel ändern":
			edit_pixels()
			return
			
func display_solution():
	if not correct_solution:
		var cinema = load("res://Assets/random_websites/cinema2.png")
		var plants = load("res://Assets/random_websites/plants2.jpg")
		var time = load("res://Assets/random_websites/time2.png")
		var zoo = load("res://Assets/random_websites/zoo2.jpg")
		var displays = [cinema, plants, time, zoo]
		var random_display = displays[randi() % displays.size()]
		display.texture = random_display
		DialogueManager.show_example_dialogue_balloon(load ("res://dialogue/main.dialogue"), "false_solution")
	if correct_solution:
		display.texture = load("res://Assets/museum2.jpg")
		GlobalTimer.end_timer("Game")
		Global.End = true
		DialogueManager.show_example_dialogue_balloon(load ("res://dialogue/main.dialogue"), "correct_solution")
		

func _on_pixel_editor_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		edit_pixels()
		GlobalTimer.start_timer("Game")
		DialogueManager.show_example_dialogue_balloon(load ("res://dialogue/main.dialogue"), "pixeleditor")
		
func edit_pixels():
	monitor_label.visible = false
	display.visible = false
	qrcode.visible = false
	pixel_editor.visible = false
	%LeftGrid.visible = true
	%RightGrid.visible = true
	if button_label.text == "Webseite suchen":
		add_buttons(%RightGrid)
		add_clickable_buttons(%LeftGrid)
	#else:
		#var grid_button: Button
		#var rect = ColorRect.new()
		#for i in range(%LeftGrid.get_child_count()):
		#	grid_button = %LeftGrid.get_child(i)
		#	grid_button.text = "1"
		#for j in range(%RightGrid.get_child_count()):
		#	rect = %RightGrid.get_child(j)
		#	rect.color = Color(1, 1, 1)
	button_label.text = "Webseite suchen"
