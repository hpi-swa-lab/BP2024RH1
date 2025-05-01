extends TextureButton

@export var is_collectible: bool = true

@export var dialogue_resource: Resource
@export var dialogue_start: String

func _ready() -> void:
	if texture_normal:
		var image: Image = texture_normal.get_image()
		var bitmap: BitMap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		texture_click_mask = bitmap
	
func _pressed() -> void:
	print("You clicked on an item!")
	DialogueManager.show_dialogue_balloon_scene("res://dialogue_balloons/monologue/balloon_monologue.tscn", dialogue_resource, dialogue_start)
	if is_collectible:
		queue_free()
