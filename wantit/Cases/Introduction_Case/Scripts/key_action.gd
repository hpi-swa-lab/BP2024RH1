extends Node

var dragging: bool
var newItem: Button
var oldItem: TextureButton

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
	var clue: Clue = null
	if not clue:
		clue = find_node()
	if clue:
		var Rect1 = Rect2(clue.position, clue.size)
		if Rect1.intersects(KeyRect):
			DialogueManager.show_dialogue_balloon_scene("res://dialogue_balloons/monologue/balloon_monologue.tscn", load("res://dialogue/door.dialogue"), "key_used")
			
			clue.clue_name = "Door"
			clue.emit_signal("clue_found", clue)
	oldItem.emit_signal("clue_found", oldItem)
	
func find_node() -> Node:		# HArdcoded Scene Names cause its easieer here
	for child in get_parent().get_children():
		print(child.name)
		if child.name == "Door CloseUp":
			return child.find_child("Key Hole")
	return null
	
