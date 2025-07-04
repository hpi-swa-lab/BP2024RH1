extends Item

var dragging: bool
var newItem: Button
var extended_item: Item

var item: Item = null
var location: Location

func _ready() -> void:
	initialize_new_item()
	get_tree().root.add_child(newItem)
	
	dragging = true
	set_process_input(true)

func item_up():
	await check_down()
	newItem.queue_free()
	queue_free()

func _input(event: InputEvent) -> void:
	if dragging:
		if event is InputEventMouseMotion:
			newItem.position = event.position - newItem.size / 2 * newItem.scale

func check_down():
	var KeyRect = Rect2(newItem.position, newItem.size)
	if not item:
		item = find_node()
	if item:
		var Rect1 = Rect2(item.position, item.size)
		if Rect1.intersects(KeyRect):
			DialogueManager.show_dialogue_balloon_scene("res://dialogue_balloons/monologue/balloon_monologue.tscn", load("res://dialogue/door.dialogue"), "key_used")
			await DialogueManager.dialogue_ended
			_on_dialogue_ended()
	else:
		location.item_found.emit(extended_item, location)
	
func find_node() -> Node:
	for child in get_parent().get_children():
		if child.name == "Door CloseUp":
			location = child
			return child.find_child("Key Hole")
		if child is Location:
			location = child
	return null

func _on_dialogue_ended() -> void:
	item.item_name = "Door"
	item.emit_signal("item_found", item)	

func initialize_new_item():
	var Style = StyleBoxEmpty.new()
	var button = Button.new()
	
	button.icon= extended_item.texture_normal
	button.scale = extended_item.scale
	
	button.button_up.connect(item_up)
	button.global_position = get_viewport().get_mouse_position() - button.icon.get_size() / 2 * button.scale
	
	button.add_theme_stylebox_override("hover", Style)
	button.add_theme_stylebox_override("normal", Style)
	button.add_theme_stylebox_override("pressed", Style)
	
	newItem = button
