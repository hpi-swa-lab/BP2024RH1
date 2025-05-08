extends Node2D

func _ready() -> void:
	# Loads constant Locations
	#var Library = CaseManager.Location.new(preload("res://Assets/library.png"), Vector2(0.1, 0.1), Vector2(-150, 40), preload("res://Scenes/testscene.tscn"))
	#add_location(Library) # Its not the right Scene for the Library should be changed

	# Loads next Location
	if Globals.nextScene != null:
		add_location(Globals.nextScene)
	
func add_location(Location: CaseManager.Location):	#Type of Loc_scene should be changed later once scene switching logic is implemented
	var newLocation = Button.new()
	var Style = StyleBoxEmpty.new()
	
	newLocation.position = Location.LocationPos
	newLocation.scale = Location.LocationScale
	newLocation.icon = Location.LocationTex
	
	newLocation.add_theme_stylebox_override("hover", Style)
	newLocation.add_theme_stylebox_override("normal", Style)
	newLocation.add_theme_stylebox_override("pressed", Style)
	newLocation.add_theme_stylebox_override("focus", Style)
	
	newLocation.pressed.connect(self.switch_location.bind(Location.LocationScene))
	%Control.add_child(newLocation)

func switch_location(Scene: PackedScene):
	SceneSwitcher.switch_scene(Scene)
