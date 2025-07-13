extends TextureButton
class_name Item

@export var item_name: String
@export var is_collectable: bool
@export var action_script: Script
@export var item_dialogue: Dialogue
var dialogue_player: DialoguePlayer
var is_found: bool = false
@export var closeup_texture: Texture

signal item_found(item: Item)

func _ready() -> void:
	add_to_group("location_items")
	
	if texture_normal:
		var image: Image = texture_normal.get_image()
		var bitmap: BitMap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		texture_click_mask = bitmap

func add_dialogue_player(_dialogue: Dialogue, _inventory_provider: Resource, _data: Array) -> void:
	if item_dialogue:
		dialogue_player = DialoguePlayer.new(_dialogue, _inventory_provider, _data)

func _pressed():
	if dialogue_player:
		dialogue_player.start_dialogue()
		await DialogueManager.dialogue_ended
	mark_found()
	item_found.emit(self)

func mark_found() -> void:
	is_found = true

func reset_as_uncollected() -> void:
	is_found = false
	
	if dialogue_player:
		dialogue_player.reset_played_dialogues()
