extends Location

signal case_overview_opened(location: Location)
signal case_selected(case_title: String)

func _ready() -> void:
	super._ready()
	case_overview_opened.emit(self)

func add_cases(cases_states: Dictionary) -> void:
	for _case in cases_states.keys():
		add_case(_case, cases_states[_case])

func add_case(case_title, is_completed) -> void:
	var new_case = Button.new()
	new_case.text = case_title
	if is_completed:
		set_style(new_case)
	new_case.custom_minimum_size.y = 40
	new_case.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	new_case.pressed.connect(self.on_case_selected.bind(case_title))
	%VBoxContainer.add_child(new_case)

func on_case_selected(case_title: String):
	case_selected.emit(case_title)


func set_style(button: Button) -> void:
	var style = StyleBoxFlat.new()
	style.bg_color = Color("#3F7D58")
	#B2D9C4   #A8DCAB #69B369 #3F7D58 #06923E
	style.corner_radius_top_left = 3
	style.corner_radius_top_right = 3
	style.corner_radius_bottom_left = 3
	style.corner_radius_bottom_right = 3
	
	button.add_theme_stylebox_override("normal", style)
	button.add_theme_stylebox_override("hover", style)
	button.add_theme_stylebox_override("pressed", style)
	button.add_theme_stylebox_override("disabled", style)
