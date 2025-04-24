extends Node2D

func _ready() -> void:
	print(Globals.CaseGlobals.culprit_found)
	if Globals.CaseGlobals.culprit_found:
		%SceneSwitcherButton.NextSceneString = "Cäsars_big_brother"
	else:
		%SceneSwitcherButton.NextSceneString = "decrypting_caesar"
