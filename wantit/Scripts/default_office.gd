extends Location

func _ready() -> void:
	super._ready()
	
	load_CaseBoard_Picture()
	
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

func create_bitmap(button: TextureButton):
	if button.texture_normal:
		var image: Image = button.texture_normal.get_image()
		var bitmap: BitMap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		button.texture_click_mask = bitmap
