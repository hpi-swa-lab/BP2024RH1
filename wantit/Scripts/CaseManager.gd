extends Node

class Case:
	var CaseName: String
	var FirstScene: PackedScene
	var GlobalScript: Node
	
	func _init(_CaseName: String, _FirstScene: PackedScene, _GlobalScript: Node) -> void:
		CaseName = _CaseName
		FirstScene = _FirstScene
		GlobalScript = _GlobalScript

class Hint:					# Hints that are shown at the Board
	var HintPos: Vector2
	var HintTexture: CompressedTexture2D
	var HintScale: Vector2
	
	func _init(_HintPos: Vector2, _HintTexture: CompressedTexture2D, _HintScale: Vector2) -> void:
		HintPos = _HintPos
		HintTexture = _HintTexture 
		HintScale = _HintScale

class Location:
	var LocationTex: CompressedTexture2D
	var LocationScale: Vector2
	var LocationPos: Vector2
	var LocationScene: PackedScene
	
	func _init(_LocationTex: CompressedTexture2D, _LocationScale: Vector2, _LocationPos: Vector2, _LocationScene: PackedScene):
		LocationTex = _LocationTex
		LocationScale = _LocationScale
		LocationPos = _LocationPos
		LocationScene = _LocationScene

var CaseList = {}
var ClosedCases = {}

var Hints = []

func add_Case(CaseName: String, FirstScene: PackedScene, GlobalScript: Node):
	if not ClosedCases.has(CaseName):
		var newCase = Case.new(CaseName, FirstScene, GlobalScript)
		Globals.CaseGlobals = GlobalScript
		CaseList[newCase.CaseName] = newCase

func close_Case(CurrentCase: Case):
	CaseList.erase(CurrentCase.CaseName)
	Globals.selectedCase = null
	Globals.nextScene = null
	Globals.CaseGlobals = null
	Hints.clear()
	
	ClosedCases[CurrentCase.CaseName] = CurrentCase
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")

func add_Hint(HintPos: Vector2, HintTexture: CompressedTexture2D, HintScale: Vector2):
	var new_Hint = Hint.new(HintPos, HintTexture, HintScale)
	Hints.append(new_Hint)

func new_Location(LocationTex: CompressedTexture2D, LocationScale: Vector2, LocationPos: Vector2, LocationScene: PackedScene):
	var newLocation = Location.new(LocationTex, LocationScale, LocationPos, LocationScene)
	Globals.nextScene = newLocation
