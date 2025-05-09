@tool
extends Control

@export var play_scene: PackedScene
@export var quick_play_scene: PackedScene

@export var goose_height_offset: int = 20

var cursor: CompressedTexture2D = load("res://assets/donut.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(cursor.get_height() / 2, cursor.get_width() / 2))

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_play_button_button_up() -> void:
	Input.set_custom_mouse_cursor(null)
	get_tree().change_scene_to_packed(play_scene)

func _on_quickplay_button_button_up() -> void:
	Input.set_custom_mouse_cursor(null)
	get_tree().change_scene_to_packed(quick_play_scene)
