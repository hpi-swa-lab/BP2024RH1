extends Node2D

func _ready() -> void:
	# Loads constant Locations
	#var Library = CaseManager.Location.new(preload("res://Assets/library.png"), Vector2(0.1, 0.1), Vector2(-150, 40), preload("res://Scenes/testscene.tscn"))
	#add_location(Library) # Its not the right Scene for the Library should be changed

	if Globals.nextScene != null:
		add_location(Globals.nextScene)
	
func add_location(Location: CaseManager.Location):
	var newLocation = TextureButton.new()
	
	newLocation.scale = %Map.scale
	newLocation.position = Vector2(0, -27) # So that it overlaps with the map
	newLocation.texture_normal = Location.LocationTex
	
	if newLocation.texture_normal:
		var image: Image = newLocation.texture_normal.get_image()
		var bitmap: BitMap = BitMap.new()
		bitmap.create_from_image_alpha(image)
		newLocation.texture_click_mask = bitmap
	
	newLocation.pressed.connect(self.switch_location.bind(Location.LocationScene))
	%Control.add_child(newLocation)

func switch_location(Scene: PackedScene):
	SceneSwitcher.switch_scene(Scene)
