extends Control

var addedClues = {}

func add_items(Clue: Button, draggable: Button):
	var newClue = Button.new()
	newClue.icon = update_item_size(Clue.icon)
	var Style = StyleBoxEmpty.new()
	
	var newDraggable = Button.new()
	newDraggable.text = draggable.text
	newDraggable.custom_minimum_size = Vector2((self.size.x / 2) -10, (self.size.y / 5)-10)
	
	newClue.add_theme_stylebox_override("hover", Style)
	newClue.add_theme_stylebox_override("normal", Style)
	newClue.add_theme_stylebox_override("pressed", Style)
	
	newDraggable.pressed.connect(func(): remove_item(newClue, newDraggable, Clue, draggable))
	newClue.pressed.connect(func(): remove_item(newClue, newDraggable, Clue, draggable))
	
	addedClues[Clue] = (Clue == draggable.correctClue)
	
	%GridContainer.add_child(newClue)
	%GridContainer.add_child(newDraggable)

func remove_children():
	for child in %GridContainer.get_children():
		%GridContainer.remove_child(child)
	
func update_item_size(Icon: CompressedTexture2D) -> ImageTexture:	#Used to scale Icon Size
	var img = Icon.get_image()
	img.resize((self.size.x / 2) -10, (self.size.y / 5) - 10, Image.INTERPOLATE_LANCZOS)
	var newIcon = ImageTexture.create_from_image(img)
	return newIcon

func remove_item(newClue: Button, newDraggable: Button, Clue: Button, draggable: Button):
	%GridContainer.remove_child(newClue)
	%GridContainer.remove_child(newDraggable)
	addedClues.erase(Clue)
	Clue.show()
	draggable.show()

func check_clues() -> bool:
	var cluesCorrect = true
	for Clue in addedClues:
		if addedClues[Clue] == false:
			cluesCorrect = false
	if addedClues.size() != 5:
		cluesCorrect = false
	return cluesCorrect
