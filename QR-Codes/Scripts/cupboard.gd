extends Button

@export var camera: Camera2D
@export var book: Button
@export var safe: Button
@export var zoom_out: Button
@export var back: Button
@export var paper: Sprite2D

var camera_start: Vector2 = Vector2(576, 324)
var camera_cupboard: Vector2 = Vector2(100,350)
var zoom_cupboard: Vector2 = Vector2(0.5,0.5)
var is_zoomed: bool
var columns = 8
var solution = "10100010" + "00000001" + "11100011" + "10100110" + "11100011" + "00000010" + "00100001" + "11001100"

func _on_ready() -> void:
	zoom_out.visible = false
	book.visible = false
	safe.visible = false
	
func _process(delta):
	if Global.Card_collected == true and Global.Paper_collected == true:
		back.visible = true
	if Global.Paper_collected == true:
		paper.visible = false

func _on_gui_input(event: InputEvent) -> void:
	if  event is InputEventMouseButton and event.is_pressed():
		zoom()

func zoom():
	camera.zoom += zoom_cupboard
	camera.position = camera_cupboard
	book.visible = true
	safe.visible = true
	zoom_out.visible = true
	self.visible = false

func _on_zoom_out_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		camera.zoom = Vector2(1,1)
		camera.position = camera_start
		self.visible = true
		zoom_out.visible = false

func _on_picture_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		DialogueManager.show_example_dialogue_balloon(load ("res://dialogue/main.dialogue"), "picture")

func _on_book_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		get_tree().change_scene_to_file("res://Scenes/book.tscn")

func _on_safe_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		DialogueManager.show_example_dialogue_balloon(load ("res://dialogue/main.dialogue"), "safe")

func _on_back_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		Global.Intro_done = true
		get_tree().change_scene_to_file("res://Scenes/office.tscn")

func _on_cushion_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if not Global.Paper_collected:
			paper.visible = true
			%SolutionGrid.columns = columns
			add_solution_Grid(%SolutionGrid)
			DialogueManager.show_example_dialogue_balloon(load ("res://dialogue/main.dialogue"), "paper")

func add_solution_Grid(Grid: GridContainer):
	for i in range(columns * columns):
		var rect = ColorRect.new()
		rect.custom_minimum_size = Vector2(Grid.size.x / columns, Grid.size.y / columns)
		if solution[i] == "1":
			rect.color = Color(224,224,224)
		elif solution[i] == "0":
			rect.color = Color(0, 0, 0)
		Grid.add_child(rect)

func _on_paper_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		paper.visible = false
