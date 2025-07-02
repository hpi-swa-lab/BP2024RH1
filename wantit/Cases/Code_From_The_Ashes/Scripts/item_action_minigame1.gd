extends Item

var extended_item: Item
var location: Location

func _ready():
	for child in get_parent().get_children():
		if child.name == "Minigame1":
			location = child
			DialogueManager.show_dialogue_balloon_scene(
			extended_item.item_dialogue.baloon_type,
			extended_item.item_dialogue.dialogue_resource,
			"minigame1")
			await DialogueManager.dialogue_ended
			check_and_apply_caesar()
		elif child.name == "Minigame2":
			location = child
			DialogueManager.show_dialogue_balloon_scene(
			extended_item.item_dialogue.baloon_type,
			extended_item.item_dialogue.dialogue_resource,
			"minigame2")
			await DialogueManager.dialogue_ended
			check_and_apply_caesar()

func check_and_apply_caesar():
	if extended_item.item_name == "Caesar":
		var label = Label.new()
		label.add_theme_font_size_override("font_size", 30)
		label.add_theme_color_override("font_color", Color.BLACK)
		label.text = "CAESAR = GEIWEV"
		label.position = Vector2(600, 150)
		location.add_child(label)
		location.item_found.emit(extended_item, location)
	else:
		location.item_found.emit(extended_item, location)
