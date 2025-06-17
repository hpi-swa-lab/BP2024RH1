extends TextureButton
class_name Item

@export var item_name: String
@export var is_collectable: bool
var is_found: bool
@export var action_script: Script
@onready var dialogue = $DialogueComponent

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
	
	if dialogue:
		dialogue.start_dialogue()
	
	await DialogueManager.dialogue_ended
	mark_found()
	item_found.emit(self)

func mark_found():
	is_found = true
