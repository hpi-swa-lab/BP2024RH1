extends Location

@onready var draggables = %Draggables.get_children()
@onready var minigame_clues = %Control.get_children()

var searching: bool
var draggedItems = 0
var clueRects = {}

func _ready() -> void:
	super._ready()
	case.inventory.hide()
	
	DialogueManager.show_dialogue_balloon_scene(load("res://dialogue_balloons/monologue/balloon_monologue.tscn"), load("res://dialogue/minigame1.dialogue"), "minigame1_start")
	for draggable in draggables:
		draggable.check.connect(func(): check_draggables(draggable))
		
	for clue in minigame_clues:
		var clueRect = Rect2(clue.position, clue.size * clue.scale) # The size gets fucked when using pictures
		clueRects[clue] = clueRect
		
func check_draggables(draggable: Button):
	var draggableRect: = Rect2(draggable.position, draggable.size)
	
	for clue in minigame_clues:
		if draggableRect.intersects(clueRects[clue]) and clue.visible:
			draggedItems += 1
			%ControlPanel.add_items(clue, draggable)
			draggable.hide()
			clue.hide()

func _on_button_pressed() -> void:
	if %ControlPanel.check_minigame_clues():
		%Label.text = "Richtig!"
		%Label.show()
		%TryAgain.hide()
		DialogueManager.show_dialogue_balloon_scene(load("res://dialogue_balloons/monologue/balloon_monologue.tscn"), load("res://dialogue/minigame1.dialogue"), "minigame1_end")
	else:
		%Label.show()
		%Label.text = "Das war leider Falsch.\nProbier es noch einmal"

func _on_try_again_pressed() -> void:
	draggedItems = 0
	%Label.hide()
	for draggable in draggables:
		draggable.show()
	for clue in minigame_clues:
		clue.show()
	%ControlPanel.remove_children()

func _on_magnifying_glass_searching(start: bool) -> void:
	searching = start
	if not start:
		for child in %Control.get_children():
			child.not_hovered()

func _input(event):
	if event is InputEventMouseMotion and searching:
		for child in %Control.get_children():
			if child.is_hovered():
				child.hovered()
			else:
				child.not_hovered()
