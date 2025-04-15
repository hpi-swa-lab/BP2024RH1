extends Node2D

@export var Button_pos: Vector2
var selected_Scene: PackedScene

func _ready() -> void:
	for Case in CaseManager.CaseList:
		load_Case(CaseManager.CaseList[Case])

func _on_back_button_pressed() -> void:
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")

func load_Case(Case: CaseManager.Case) -> void:		#A Case Type should also be added here or an alternativ connection how cases are loaded
	var new_Case = Button.new()
	new_Case.text = Case.CaseName
	new_Case.custom_minimum_size.y = 40
	new_Case.pressed.connect(self.Case_button_pressed.bind(Case))
	%VBoxContainer.add_child(new_Case)

func Case_button_pressed(Case) -> void:
	%SelectButton.visible = true
	Globals.selectedCase = Case
	
func _on_select_button_pressed() -> void:
	SceneSwitcher.switch_scene(Globals.selectedCase.FirstScene)
