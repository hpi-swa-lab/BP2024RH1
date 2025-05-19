extends Node

var CaseGlobals: Node = null # The script for Globals in each Case will be loaded in here. The Globals can be accessed via: Globals.CaseGlobals.<var_name>

var all_clues_found_scene: Resource

var clues_completed: bool = false

func clue_found() -> void:	
	if all_clues_found():
		clues_completed = true
		change_scene()
	
func all_clues_found() -> bool:
	for hint in CaseGlobals.get_hints():
		if hint != true:
			return false
	return true	

func change_scene() -> void:
	if not "all_clues_found_scene" in CaseGlobals:
		push_error("Invalid Global Script for Case: all_clues_found_Scene not found")
		return
	
	all_clues_found_scene = CaseGlobals.all_clues_found_scene
	SceneSwitcher.switch_scene(all_clues_found_scene)
	 
class Case:
	var CaseName: String
	var FirstScene: PackedScene
	var EndScreen: PackedScene
	var GlobalScript: Node
	
	func _init(_CaseName: String, _FirstScene: PackedScene, _GlobalScript: Node, _EndScreen: PackedScene) -> void:
		CaseName = _CaseName
		FirstScene = _FirstScene
		GlobalScript = _GlobalScript
		EndScreen = _EndScreen

class Hint:					# Hints that are shown at the Board
	var HintPos: Vector2
	var HintTexture: CompressedTexture2D
	var HintScale: Vector2
	
	func _init(_HintPos: Vector2, _HintTexture: CompressedTexture2D, _HintScale: Vector2) -> void:
		HintPos = _HintPos
		HintTexture = _HintTexture 
		HintScale = _HintScale

class Location:
	var LocationTex: Texture2D
	var LocationScene: PackedScene
	
	func _init(_LocationTex: Texture2D, _LocationScene: PackedScene):
		LocationTex = _LocationTex
		LocationScene = _LocationScene

var CaseList = {}
var ClosedCases = {}

var Hints = []

func add_Case(CaseName: String, FirstScene: PackedScene, GlobalScript: Node, EndScreen: PackedScene):
	if not ClosedCases.has(CaseName):
		var newCase = Case.new(CaseName, FirstScene, GlobalScript, EndScreen)
		CaseGlobals = GlobalScript
		CaseList[newCase.CaseName] = newCase

func close_Case(CurrentCase: Case):
	print(GlobalTimer.print_times())
	
	CaseList.erase(CurrentCase.CaseName)
	Globals.selectedCase = null
	Globals.nextScene = null
	CaseGlobals = null
	Hints.clear()
	
	ClosedCases[CurrentCase.CaseName] = CurrentCase
	GlobalTimer.end_timer("insgesamt")
	
	SceneSwitcher.switch_scene(CurrentCase.EndScreen)

func add_Hint(HintPos: Vector2, HintTexture: CompressedTexture2D, HintScale: Vector2):
	var newHint = Hint.new(HintPos, HintTexture, HintScale)
	Hints.append(newHint)

func new_Location(LocationTex: Texture2D, LocationScene: PackedScene):
	var newLocation = Location.new(LocationTex, LocationScene)
	Globals.nextScene = newLocation
