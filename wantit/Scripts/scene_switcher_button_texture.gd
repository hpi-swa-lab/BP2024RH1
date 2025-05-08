extends TextureButton

@export var NextSceneString: String

func _ready() -> void:
	if texture_normal:
		var image: Image = texture_normal.get_image()
		var bitmap: BitMap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		texture_click_mask = bitmap
		
func _on_pressed() -> void:
	#var Folder: String = ""
	#if NextSceneString == "office":
	#	SceneSwitcher.switch_scene("res://Scenes/office.tscn")
	#elif Globals.selectedCase != null:
	#	Folder = "Cases/" + Globals.selectedCase.CaseName
	#SceneSwitcher.switch_scene("res://" + Folder + "/Scenes/" + NextSceneString + ".tscn")
	SceneSwitcher.switch_scene("res://Cases/Introduction_Case/scenes/" + NextSceneString + ".tscn")
