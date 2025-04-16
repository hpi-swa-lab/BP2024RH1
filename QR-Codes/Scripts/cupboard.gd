extends Button

@export var camera: Camera2D
@export var book: Button
@export var safe: Button
@export var zoom_out: Button

var camera_start: Vector2 = Vector2(576, 324)
var camera_cupboard: Vector2 = Vector2(100,350)
var zoom_cupboard: Vector2 = Vector2(0.5,0.5)
var is_zoomed: bool

func _on_ready() -> void:
	zoom_out.visible = false
	book.visible = false
	safe.visible = false

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
		SceneSwitcher.switch_scene("res://Scenes/book.tscn")


func _on_safe_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		DialogueManager.show_example_dialogue_balloon(load ("res://dialogue/main.dialogue"), "safe")


func _on_back_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		SceneSwitcher.switch_scene("res://Scenes/office.tscn")
