extends Control

const SPEECH_BUBBLE = preload("res://assets/speech-bubble.png")
const CAT_AWAKE = preload("res://assets/cat_awake.png")
const CAT_SLEEPING = preload("res://assets/cat_sleeping.png")
const CAT_SLEEPING_MOUSE = preload("res://assets/cat_sleeping_mouse.png")

@onready var texture_button: TextureButton = $TextureButton

func _ready() -> void:
	texture_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	Input.set_custom_mouse_cursor(SPEECH_BUBBLE, Input.CURSOR_POINTING_HAND)
	go_to_sleep()
	# audio_player.play()

func _process(delta: float) -> void:
	if State.is_awake:
		wake_up()
	else:
		go_to_sleep()	
		
	if State.search_status == "ended":
		texture_button.mouse_default_cursor_shape = Control.CURSOR_ARROW
		
	if State.ending == "good":
		cuddle_with_mouse()
		
func go_to_sleep() -> void:
	texture_button.texture_normal = CAT_SLEEPING
	create_click_mask()
 
func wake_up() -> void:
	texture_button.texture_normal = CAT_AWAKE
	create_click_mask()
	
func cuddle_with_mouse() -> void:
	texture_button.texture_normal = CAT_SLEEPING_MOUSE
	create_click_mask()
	
func _on_texture_button_button_down() -> void:
	DialogueManager.show_dialogue_balloon(load("res://biscuit.dialogue"), "start")
	
func create_click_mask() -> void:
	if texture_button.texture_normal:
		# Get the image from the texture normal
		var image = texture_button.texture_normal.get_image()
		# Create the BitMap
		var bitmap = BitMap.new()
		# Fill it from the image alpha
		bitmap.create_from_image_alpha(image)
		# Assign it to the mask
		texture_button.texture_click_mask = bitmap
