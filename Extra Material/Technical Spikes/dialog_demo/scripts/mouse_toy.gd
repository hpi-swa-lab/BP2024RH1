extends Control

const HAND = preload("res://assets/hand.png")
const INTERACTABLE_BALLOON = preload("res://dialogue_balloon/interactable_balloon.tscn")

@onready var texture_button: TextureButton = $TextureButton
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	texture_button.mouse_default_cursor_shape = Control.CURSOR_ARROW
	
	if texture_button.texture_normal:
		# Get the image from the texture normal
		var image = texture_button.texture_normal.get_image()
		# Create the BitMap
		var bitmap = BitMap.new()
		# Fill it from the image alpha
		bitmap.create_from_image_alpha(image)
		# Assign it to the mask
		texture_button.texture_click_mask = bitmap
		
func _process(delta: float) -> void:
	if State.search_status == "successful":
		queue_free()

func _unhandled_input(event: InputEvent) -> void:	
	if State.search_status == "started":
		texture_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		Input.set_custom_mouse_cursor(HAND, Input.CURSOR_POINTING_HAND)
		
func _on_texture_button_button_down() -> void:
	if State.search_status == "started":
		audio_stream_player.play()
		DialogueManager.show_dialogue_balloon_scene(INTERACTABLE_BALLOON, load("res://interactables.dialogue"), "mouse", [])
