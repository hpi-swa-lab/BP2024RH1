extends Location

signal case_overview_opened(location: Location)
signal case_selected(case_title: String)

func _ready() -> void:
	super._ready()
	case_overview_opened.emit(self)

func add_cases(cases_states: Dictionary) -> void:
	add_header()
	for _case in cases_states.keys():
		add_case(_case, cases_states[_case][0], cases_states[_case][1])

func add_case(case_title, is_completed, case_topic) -> void:
	var row = HBoxContainer.new()
	row.custom_minimum_size.y = 80
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.size_flags_vertical = Control.SIZE_FILL

	# Fall-Button
	var new_title = Button.new()
	new_title.text = case_title
	new_title.scale = Vector2(0.5, 0.5)
	new_title.custom_minimum_size.y = 80
	var style = StyleBoxFlat.new()
	if is_completed:
		style.bg_color = Color("#3F7D58")
		#B2D9C4   #A8DCAB #69B369 #3F7D58 #06923E
	else:
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
	new_title.add_theme_color_override("font_color", Color.BLACK)
	new_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	new_title.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	new_title.pressed.connect(self.on_case_selected.bind(case_title))
	row.add_child(new_title)
	
	row.add_theme_constant_override("separation", 40)  # Standard ist 4

	# Thema-Label
	var new_topic = Label.new()
	new_topic.scale = Vector2(0.5, 0.5)
	new_topic.text = case_topic
	new_topic.custom_minimum_size.y = 80
	new_topic.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	new_topic.add_theme_color_override("font_color", Color.BLACK)
	new_topic.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(new_topic)

	# Zeile zur VBoxContainer hinzufügen
	%VBoxContainer.add_child(row)

	
func add_header() -> void:
	var row = HBoxContainer.new()
	row.custom_minimum_size.y = 80
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.size_flags_vertical = Control.SIZE_FILL

	# Fall-Button
	var new_title = Label.new()
	new_title.text = "Fall"
	new_title.custom_minimum_size.y = 80
	new_title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	new_title.add_theme_color_override("font_color", Color.BLACK)
	new_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(new_title)
	
	row.add_theme_constant_override("separation", 40) 

	# Thema-Label
	
	var new_topic = Label.new()
	new_topic.text = "Thema"
	new_topic.custom_minimum_size.y = 80
	new_topic.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	new_topic.add_theme_color_override("font_color", Color.BLACK)
	new_topic.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(new_topic)
	
	%VBoxContainer.add_child(row)

func on_case_selected(case_title: String):
	case_selected.emit(case_title)
