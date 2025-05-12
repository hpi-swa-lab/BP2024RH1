extends Control

func _ready() -> void:
	load_CaseBoard_Picture()
	add_basic_cases()
	print(Globals.OfficeDialogueDone)
	
	if not Globals.OfficeDialogueDone:
		if Globals.selectedCase == null:
			Globals.OfficeDialogue = "res://dialogue/dialogue.dialogue"
			Globals.OfficeDialogueStart = "begin"
	
		if Globals.OfficeDialogue != null:
			DialogueManager.show_dialogue_balloon(load(Globals.OfficeDialogue), Globals.OfficeDialogueStart)
			Globals.OfficeDialogueDone = true
			
	create_bitmap(%clue_board)
	create_bitmap(%computer)
	create_bitmap(%map)


func load_CaseBoard_Picture():
	var CaseBoardPicture
	#if Globals.selectedCase == null:
	CaseBoardPicture = load("res://Assets/clue_board_max.png")
	#else:		# Doesnt work on web
		#var image = Image.new()
		#var error = image.load("user://Assets/Hinweistafel.png")
		#if error != OK:
			#print("Fehler beim Laden des Bildes:", error)
		#else:
			#CaseBoardPicture = ImageTexture.new().create_from_image(image)
	%clue_board.texture_normal = CaseBoardPicture

func add_basic_cases():
	CaseManager.add_Case("Einführungsfall", load("res://Cases/Introduction_Case/Scenes/introduction_start.tscn"), load("res://Cases/Introduction_Case/Scripts/state.gd").new(), load("res://Cases/Introduction_Case/Scenes/intro_endscreen.tscn"))

func create_bitmap(button: TextureButton):
	if button.texture_normal:
		var image: Image = button.texture_normal.get_image()
		var bitmap: BitMap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		button.texture_click_mask = bitmap

func _on_clue_board_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		SceneSwitcher.switch_scene("res://Scenes/hinweistafel.tscn")


func _on_computer_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if not Globals.selectedCase:
			SceneSwitcher.switch_scene("res://Scenes/fallübersicht.tscn")


func _on_map_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		SceneSwitcher.switch_scene("res://Scenes/map.tscn")
