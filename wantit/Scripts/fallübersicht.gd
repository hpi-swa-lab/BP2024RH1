extends Node2D

func _ready() -> void:
	for Case in CaseManager.CaseList:
		load_Case(CaseManager.CaseList[Case])

func load_Case(Case: CaseManager.Case) -> void:
	var newCase = Button.new()
	newCase.text = Case.CaseName
	newCase.custom_minimum_size.y = 40
	newCase.pressed.connect(self.Case_button_pressed.bind(Case))
	%VBoxContainer.add_child(newCase)

func Case_button_pressed(Case) -> void:
	%SelectButton.visible = true
	Globals.selectedCase = Case
	
func _on_select_button_pressed() -> void:
	SceneSwitcher.switch_scene(Globals.selectedCase.FirstScene)
	var img = load("res://Assets/Hinweistafel_basic.png").get_image()
	img.save_png("user://Assets/Hinweistafel.png")
	CaseManager.Hints.clear()
