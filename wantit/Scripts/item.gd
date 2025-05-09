extends TextureButton

@export var is_collectible: bool = true

@export var dialogue_resource: Resource
@export var dialogue_start: String

@export var ActionScript: Script

func _ready() -> void:
	if texture_normal:
		var image: Image = texture_normal.get_image()
		var bitmap: BitMap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		texture_click_mask = bitmap
	
func _pressed() -> void:
	if not is_collectible:
		DialogueManager.show_dialogue_balloon_scene("res://dialogue_balloons/monologue/balloon_monologue.tscn", dialogue_resource, dialogue_start)
		await DialogueManager.dialogue_ended
		CaseManager.clue_found()
	else:
		GlobalInventory.add_item(self)
		GlobalInventory.show_inventory()
		if not CaseManager.CaseGlobals.inventory_explained:
			DialogueManager.show_dialogue_balloon_scene("res://dialogue_balloons/monologue/balloon_monologue.tscn", load("res://dialogue/monologue.dialogue"), "inventory")
			await DialogueManager.dialogue_ended
		DialogueManager.show_dialogue_balloon_scene("res://dialogue_balloons/monologue/balloon_monologue.tscn", dialogue_resource, dialogue_start)
		await DialogueManager.dialogue_ended
		GlobalInventory.hide_inventory()
		CaseManager.clue_found()
		queue_free()
