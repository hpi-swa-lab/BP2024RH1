extends TextureButton

class_name Clue

signal clue_found(clue: Clue)

@export var clue_name: String
@export var is_collectable: bool
var is_found: bool
@export var dialogue: Dialogue
@export var action_script: Script

#from item.gd
func _ready() -> void:
	add_to_group("location_clues")
	
	if texture_normal:
		var image: Image = texture_normal.get_image()
		var bitmap: BitMap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		texture_click_mask = bitmap

func _pressed():
	if is_found:
		return

	mark_found()
	if dialogue != null and not dialogue.is_started:
		start_dialogue(dialogue)
	emit_signal("clue_found", self)

func start_dialogue(dialogue:Dialogue, dialogue_start: String = "default"):
	DialogueManager.show_dialogue_balloon_scene(
			dialogue.baloon_type,
			dialogue.dialogue_resource,
			dialogue_start)
	await DialogueManager.dialogue_ended

func mark_found():
	is_found = true
