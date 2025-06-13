extends TextureButton
class_name Item

@export var item_name: String
@export var is_collectable: bool
var is_found: bool
@export var dialogue: Dialogue
@export var action_script: Script

signal item_found(item: Item)

func _ready() -> void:
	add_to_group("location_items")
	
	if texture_normal:
		var image: Image = texture_normal.get_image()
		var bitmap: BitMap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		texture_click_mask = bitmap

func _pressed():
	if is_found:
		return

	if not is_found:
		mark_found()
		item_found.emit(self)
	if dialogue != null:
		start_dialogue(dialogue)
	

func start_dialogue(dialogue:Dialogue, dialogue_start: String = "default"):
	DialogueManager.show_dialogue_balloon_scene(
			dialogue.baloon_type,
			dialogue.dialogue_resource,
			dialogue_start)
	await DialogueManager.dialogue_ended

func mark_found():
	is_found = true
