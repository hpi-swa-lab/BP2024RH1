extends Node2D

# got a bit laggy when adding the new pictures, probably because of the resizing and stuff

@onready var draggables = %Draggables.get_children()
@onready var clues = %Control.get_children()

var draggedItems = 0

func _ready() -> void:
	for draggable in draggables:
		draggable.check.connect(func(): check_draggables(draggable))
	
func check_draggables(draggable: Button):
	var draggableRect: Rect2
	var clueRect: Rect2
	
	for clue in clues:
		clueRect = Rect2(clue.position, clue.size * clue.scale)		# The size gets fucked when using pictures
		draggableRect = Rect2(draggable.position, draggable.size)
		
		if draggableRect.intersects(clueRect):
			draggedItems += 1
			%ControlPanel.add_items(clue, draggable)
			draggable.hide()
			clue.hide()

func _on_button_pressed() -> void:
	if %ControlPanel.check_clues():
		print("nice")
		# Do something
	else:
		%Label.show()

func _on_try_again_pressed() -> void:
	draggedItems = 0
	%Label.hide()
	for draggable in draggables:
		draggable.show()
	for clue in clues:
		clue.show()
	%ControlPanel.remove_children()
