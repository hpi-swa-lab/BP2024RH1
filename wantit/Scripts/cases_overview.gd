extends Location

signal case_overview_opened(location: Location)
signal case_selected(case_title: String)

func _ready() -> void:
	super._ready()
	case_overview_opened.emit(self)

#func Case_button_pressed(Case) -> void:
	#%SelectButton.visible = true
	#Globals.selectedCase = Case
	#
#func _on_select_button_pressed() -> void:
	#SceneSwitcher.switch_scene(Globals.selectedCase.FirstScene)
	##var img = load("res://Assets/Hinweistafel_basic.png").get_image()	# Doesnt work on web
	##img.save_png("user://Assets/Hinweistafel.png")
	#CaseManager.Hints.clear()

func add_cases(cases_list: Array) -> void:
	for _case in cases_list:
		add_case(_case)

func add_case(case_title) -> void:
	#create pre-configured case_selection_button that could be enabled/disabled for completed cases
	var new_case = Button.new()
	new_case.text = case_title
	new_case.custom_minimum_size.y = 40
	new_case.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	new_case.pressed.connect(self.on_case_selected.bind(case_title))
	%VBoxContainer.add_child(new_case)

func on_case_selected(case_title: String):
	case_selected.emit(case_title)
