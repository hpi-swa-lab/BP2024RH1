extends TextureButton
class_name Item

@export var item_name: String
@export var is_collectable: bool
var is_found: bool
@export var action_script: Script
@export var item_dialogue: Dialogue
var dialogue_player: DialoguePlayer

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
	#print("%s clicked" %[item_name])
	#if is_found:
		#return
	if dialogue_player:
		dialogue_player.start_dialogue()
		await DialogueManager.dialogue_ended
	mark_found()
	item_found.emit(self)

func mark_found():
	is_found = true
