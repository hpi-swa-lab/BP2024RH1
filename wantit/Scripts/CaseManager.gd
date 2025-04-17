extends Node

class Case:				#Does not have to be a class right now, because of the dict but could prove useful
	var CaseName: String
	var FirstScene: PackedScene
	
	func _init(_CaseName: String, _FirstScene: PackedScene) -> void:
		CaseName = _CaseName
		FirstScene = _FirstScene

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

func add_Case(CaseName: String, FirstScene: PackedScene):
	if not ClosedCases.has(CaseName):
		var newCase = Case.new(CaseName, FirstScene)
		CaseList[newCase.CaseName] = newCase

func close_Case(CurrentCase: Case):
	CaseList.erase(CurrentCase.CaseName)
	Globals.selectedCase = null
	Globals.nextScene = null
	Hints.clear()
	
	ClosedCases[CurrentCase.CaseName] = CurrentCase
	SceneSwitcher.switch_scene("res://Scenes/office.tscn")	# Muss hier nicht immer das Office sein

func add_Hint(HintPos: Vector2, HintTexture: CompressedTexture2D):
	var new_Hint = Hint.new(HintPos, HintTexture)
	Hints.append(new_Hint)

func new_Location(LocationTex: CompressedTexture2D, LocationScale: Vector2, LocationPos: Vector2, LocationScene: PackedScene):
	var newLocation = Location.new(LocationTex, LocationScale, LocationPos, LocationScene)
	Globals.nextScene = newLocation
