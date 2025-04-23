extends Node3D

func _ready() -> void:
	add_basic_cases()
	load_CaseBoard_Picture()
	
	if Globals.selectedCase != null and Globals.OfficeDialogue != null:
		DialogueManager.show_dialogue_balloon(load(Globals.OfficeDialogue), Globals.OfficeDialogueStart)
	
func _on_pc_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if not Globals.selectedCase:
			SceneSwitcher.switch_scene("res://Scenes/fallübersicht.tscn")
		else: 
			print("Finish your Case first")

func _on_map_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		SceneSwitcher.switch_scene("res://Scenes/map.tscn")

func _on_board_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		SceneSwitcher.switch_scene("res://Scenes/hinweistafel.tscn")

func load_CaseBoard_Picture():
	var CaseBoardPicture
	#if Globals.selectedCase == null:
	CaseBoardPicture = load("res://Assets/Hinweistafel_basic.png")
	#else:		# Doesnt work on web
		#var image = Image.new()
		#var error = image.load("user://Assets/Hinweistafel.png")
		#if error != OK:
			#print("Fehler beim Laden des Bildes:", error)
		#else:
			#CaseBoardPicture = ImageTexture.new().create_from_image(image)
	%CaseBoard.texture = CaseBoardPicture

func add_basic_cases():
	CaseManager.add_Case("Caesar", load("res://Cases/Caesar/Scenes/Caesar_Start.tscn"), load("res://Cases/Caesar/Scripts/global.gd").new())
	#CaseManager.add_Case("Test2", load("res://Scenes/testscene.tscn"), load("res://Cases/Caesar/Scripts/global.gd").new())
	#CaseManager.add_Case("Test3", load("res://Scenes/testscene.tscn"), load("res://Cases/Caesar/Scripts/global.gd").new())
