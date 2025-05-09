extends Node

var dragging: bool
var newItem: Button
var oldItem: TextureButton
var DialogueStart: String

func do_smt(Item: TextureButton):
	oldItem = Item
	var Style = StyleBoxEmpty.new()
	
	var button = Button.new()
	button.icon= Item.texture_normal
	button.scale = Item.scale
	
	button.button_up.connect(item_up)
	button.global_position = get_viewport().get_mouse_position() - button.icon.get_size() / 2 * button.scale
	
	button.add_theme_stylebox_override("hover", Style)
	button.add_theme_stylebox_override("normal", Style)
	button.add_theme_stylebox_override("pressed", Style)
	
	newItem = button
	
	get_tree().root.add_child(newItem)
	
	dragging = true
	set_process_input(true)

func item_up():
	check_down()
	newItem.queue_free()
	queue_free()

func _input(event: InputEvent) -> void:
	if dragging:
		if event is InputEventMouseMotion:
			newItem.position = event.position - newItem.size / 2 * newItem.scale

func check_down():
	var KeyRect = Rect2(newItem.position, newItem.size)
	var node: Node = null
	if not node:
		node = find_node()
	if node:
		var Rect1 = Rect2(node.position, node.size)
		if Rect1.intersects(KeyRect):
			DialogueManager.show_dialogue_balloon_scene("res://dialogue_balloons/monologue/balloon_monologue.tscn", load("res://dialogue/monologue.dialogue"), DialogueStart)
			await DialogueManager.dialogue_ended
			CaseManager.clue_found()
			return
	GlobalInventory.add_item(oldItem)
	
func find_node() -> Node:		# HArdcoded Scene Names cause its easieer here
	for child in get_tree().root.get_children():
		print(child.name)
		if child.name == "Door CloseUp":
			DialogueStart = "key_on_door"
			return child.find_child("Key Hole")
		elif child.name == "Bakery Office":
			DialogueStart = "key_on_safe"
			GlobalInventory.add_item(oldItem)
			return child.find_child("Safe")
	return null
	
