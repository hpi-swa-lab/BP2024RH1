extends Node2D

func _ready() -> void:
	var test_scale = Vector2(0.1, 0.1)
	var test_tex = preload("res://Assets/library.png")
	var test_pos = Vector2(-150, 40)
	var test_scene = "Bibliothek"
	add_location(test_pos, test_scale, test_tex, test_scene)
	add_location(Vector2(100, 25), test_scale, test_tex, "2") # only for testing

func _on_back_button_pressed() -> void:
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")

func add_location(Loc_pos: Vector2, Loc_scale: Vector2, Loc_tex: CompressedTexture2D, Loc_scene: String):	#Type of Loc_scene should be changed later once scene switching logic is implemented
	var Location = Button.new()
	var Style = StyleBoxEmpty.new()
	
	Location.position = Loc_pos
	Location.scale = Loc_scale
	Location.icon = Loc_tex
	
	Location.add_theme_stylebox_override("hover", Style)
	Location.add_theme_stylebox_override("normal", Style)
	Location.add_theme_stylebox_override("pressed", Style)
	
	Location.pressed.connect(self.switch_location.bind(Loc_scene))
	%Control.add_child(Location)

# An Alternativ logic to having to add them manually would we to have globals like Case_locations which would
# be set upon selecting a case and then you would just have to load them instead of the given values like here.

func switch_location(Scene: String):	#Should be changed according to earlier
	print(Scene)
