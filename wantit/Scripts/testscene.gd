extends Node2D

func _ready() -> void:
	$Label.text = Globals.selectedCase.CaseName
	
	CaseManager.add_Hint(Vector2(400, 200), load("res://icon.svg"))
	CaseManager.add_Hint(Vector2(100, 400), load("res://icon.svg"))
	
	CaseManager.new_Location(preload("res://Assets/library.png"), Vector2(0.1, 0.1), Vector2(150, 100), preload("res://Scenes/testscene.tscn"))

func _on_button_pressed() -> void:
	CaseManager.close_Case(Globals.selectedCase)

func _on_button_2_pressed() -> void:
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")
