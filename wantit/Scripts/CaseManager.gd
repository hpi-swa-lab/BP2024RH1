extends Node

class Case:
	var CaseName: String
	var FirstScene: PackedScene
	
	func _init(_CaseName: String, _FirstScene: PackedScene) -> void:
		CaseName = _CaseName
		FirstScene = _FirstScene

var CaseList = {}
var ClosedCases = {}

func add_Case(CaseName: String, FirstScene: PackedScene):
	if not ClosedCases.has(CaseName):
		var new_Case = Case.new(CaseName, FirstScene)
		CaseList[new_Case.CaseName] = new_Case

func close_Case(CurrentCase: Case):
	CaseList.erase(CurrentCase.CaseName)
	Globals.selectedCase = null
	ClosedCases[CurrentCase.CaseName] = CurrentCase
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")	# Muss hier nicht immer das Office sein
