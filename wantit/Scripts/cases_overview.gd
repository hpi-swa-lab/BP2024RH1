extends Location

signal case_overview_opened(location: Location)
signal case_selected(case_title: String)

func _ready() -> void:
	super._ready()
	case_overview_opened.emit(self)
	add_cases()
	#for case in cases_list:
	

func add_cases() -> void:
	#for case in cases_list:
	add_header("Fall", "Thema")
	add_case("Einführungsfall", "Informationen und Daten")
	add_case("Fake-News-Fiasko", "Fake-News")
	add_case("Nachricht aus der Asche", "Caesar-Verschlüsselung")
	add_case("Ein ganz normaler Tag", "Logikgatter")
	add_case("Die Binärfalle", "Binär-Codierung")	
	add_case("Das verschwundene Gemälde", "Pixelgrafiken")
	

func add_case(case_title, case_topic) -> void:
	var row = HBoxContainer.new()
	row.custom_minimum_size.y = 40
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.size_flags_vertical = Control.SIZE_FILL

	# Fall-Button
	var new_title = Button.new()
	new_title.text = case_title
	new_title.custom_minimum_size.y = 40
	var style = StyleBoxFlat.new()
	style.bg_color = Color.WHITE
	style.border_color = Color(0.7, 0.7, 0.7)
	style.border_width_left = 1
	style.border_width_right = 1
	style.border_width_top = 1
	style.border_width_bottom = 1
	style.corner_radius_top_left = 5
	style.corner_radius_top_right = 5
	style.corner_radius_bottom_left = 5
	style.corner_radius_bottom_right = 5
	new_title.add_theme_stylebox_override("normal", style)
	new_title.add_theme_color_override("font_color", Color.DIM_GRAY)
	new_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	new_title.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	new_title.pressed.connect(self.on_case_selected.bind(case_title))
	row.add_child(new_title)
	
	row.add_theme_constant_override("separation", 20)  # Standard ist 4

	# Thema-Label
	var new_topic = Label.new()
	new_topic.text = case_topic
	new_topic.custom_minimum_size.y = 40
	new_topic.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	new_topic.add_theme_color_override("font_color", Color.DIM_GRAY)
	new_topic.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(new_topic)

	# Zeile zur VBoxContainer hinzufügen
	%VBoxContainer.add_child(row)

	
func add_header(case_title: String, case_topic: String) -> void:
	var row = HBoxContainer.new()
	row.custom_minimum_size.y = 40
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.size_flags_vertical = Control.SIZE_FILL

	# Fall-Button
	var new_title = Button.new()
	new_title.text = case_title
	new_title.custom_minimum_size.y = 40
	var style = StyleBoxFlat.new()
	style.bg_color = Color.WHITE
	style.border_color = Color.WHITE
	new_title.add_theme_stylebox_override("hover", style)
	new_title.add_theme_stylebox_override("pressed", style)
	new_title.add_theme_stylebox_override("normal", style)
	new_title.add_theme_color_override("font_color", Color.BLACK)
	new_title.add_theme_color_override("font_color_hover", Color.BLACK)
	new_title.add_theme_color_override("font_color_pressed", Color.BLACK)
	new_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	new_title.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	row.add_child(new_title)
	
	row.add_theme_constant_override("separation", 20) 

	# Thema-Label
	
	var new_topic = Label.new()
	new_topic.text = case_topic
	new_topic.custom_minimum_size.y = 40
	new_topic.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	new_topic.add_theme_color_override("font_color", Color.BLACK)
	new_topic.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(new_topic)
	
	%VBoxContainer.add_child(row)

func on_case_selected(case_title: String):
	case_selected.emit(case_title)
