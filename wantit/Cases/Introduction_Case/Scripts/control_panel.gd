extends Control

@export var ItemsNum: int

var addedPairs: int = 0
var addedClues = {}

func _ready() -> void:
	%VBoxContainer.custom_minimum_size = self.size
	for i in ItemsNum -1:
		%HBoxContainer.custom_minimum_size.y = (%VBoxContainer.size.y / ItemsNum) - 3 #-3 for padding
		%VBoxContainer.add_child(%HBoxContainer.duplicate())

func add_items(Clue: Button, draggable: Button):
	var pair = %VBoxContainer.get_child(addedPairs)
	
	var newClue = pair.get_child(0)
	newClue.texture = Clue.icon
	
	var newDraggable = pair.get_child(1)
	newDraggable.text = draggable.text
	
	newDraggable.pressed.connect(func(): remove_item(pair, Clue, draggable))
	
	addedClues[Clue] = (Clue == draggable.correctClue)
	pair.show()
	addedPairs += 1

func remove_children():
	addedPairs = 0
	addedClues.clear()
	for child in %VBoxContainer.get_children():
		child.hide()

func remove_item(pair: HBoxContainer, Clue: Button, draggable: Button):
	addedClues.erase(Clue)
	pair.hide()
	Clue.show()
	draggable.show()
	addedPairs -= 1

func check_minigame_clues() -> int:
	var wrong_answers = 0
	for Clue in addedClues:
		if addedClues[Clue] == false:
			wrong_answers += 1
	if addedClues.size() != 5:
		wrong_answers = 6
	return wrong_answers
