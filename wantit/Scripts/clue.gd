extends TextureButton

class_name Clue

signal clue_found(clue: Clue)

@export var clue_name: String
@export var is_collectable: bool
var is_found: bool
@export var clue_dialogue_resource: DialogueResource
@export var clue_dialogue_start: String

#from item.gd
func _ready() -> void:
	if texture_normal:
		var image: Image = texture_normal.get_image()
		var bitmap: BitMap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		texture_click_mask = bitmap


func _on_pressed():
	if is_found:
		return

	mark_found()
	if has_dialogue():
		DialogueManager.show_dialogue_balloon_scene(
			"res://dialogue_balloons/monologue/balloon_monologue.tscn",
			clue_dialogue_resource,
			clue_dialogue_start)
		await DialogueManager.dialogue_ended
	emit_signal("clue_found", self)

func mark_found():
	is_found = true

func has_dialogue() -> bool:
	return self.clue_dialogue_resource and self.clue_dialogue_start != ""
