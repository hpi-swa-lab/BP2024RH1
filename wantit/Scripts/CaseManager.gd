extends Node

class Case:
	var CaseName: String
	var FirstScene: PackedScene
	var EndScene: PackedScene
	var GlobalScript: Node
	
	func _init(_CaseName: String, _FirstScene: PackedScene, _EndScene: PackedScene, _GlobalScript: Node) -> void:
		CaseName = _CaseName
		FirstScene = _FirstScene
		EndScene = _EndScene
		GlobalScript = _GlobalScript

class Hint:					# Hints that are shown at the Board
	var HintPos: Vector2
	var HintTexture: CompressedTexture2D
	
	func _init(_HintPos: Vector2, _HintTexture: CompressedTexture2D) -> void:
		HintPos = _HintPos
		HintTexture = _HintTexture 

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

func add_Case(CaseName: String, FirstScene: PackedScene, EndScene: PackedScene, GlobalScript: Node):
	if not ClosedCases.has(CaseName):
		var newCase = Case.new(CaseName, FirstScene, EndScene, GlobalScript)
		Globals.CaseGlobals = GlobalScript
		CaseList[newCase.CaseName] = newCase

func close_Case(CurrentCase: Case):
	CaseList.erase(CurrentCase.CaseName)
	Globals.selectedCase = null
	Globals.nextScene = null
	Hints.clear()
	
	ClosedCases[CurrentCase.CaseName] = CurrentCase
	SceneSwitcher.switch_scene(CurrentCase.EndScene)

func add_Hint(HintPos: Vector2, HintTexture: CompressedTexture2D):
	var new_Hint = Hint.new(HintPos, HintTexture)
	Hints.append(new_Hint)

func new_Location(LocationTex: CompressedTexture2D, LocationScale: Vector2, LocationPos: Vector2, LocationScene: PackedScene):
	var newLocation = Location.new(LocationTex, LocationScale, LocationPos, LocationScene)
	Globals.nextScene = newLocation
