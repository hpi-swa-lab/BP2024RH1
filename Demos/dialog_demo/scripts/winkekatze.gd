extends Control

const HAND = preload("res://assets/hand.png")
const INTERACTABLE_BALLOON = preload("res://dialogue_balloon/interactable_balloon.tscn")

@onready var button: TextureButton = $TextureButton
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	Input.set_custom_mouse_cursor(HAND, Input.CURSOR_POINTING_HAND)
	
	if button.texture_normal:
		# Get the image from the texture normal
		var image = button.texture_normal.get_image()
		# Create the BitMap
		var bitmap = BitMap.new()
		# Fill it from the image alpha
		bitmap.create_from_image_alpha(image)
		# Assign it to the mask
		button.texture_click_mask = bitmap

func _on_button_button_down() -> void:
	audio_stream_player.play()
	DialogueManager.show_dialogue_balloon_scene(INTERACTABLE_BALLOON, load("res://interactables.dialogue"), "winkekatze", [])
