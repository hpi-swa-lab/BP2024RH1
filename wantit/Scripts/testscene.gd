extends Node2D

func _ready() -> void:
	$Label.text = Globals.selectedCase.CaseName


func _on_button_pressed() -> void:
	CaseManager.close_Case(Globals.selectedCase)
