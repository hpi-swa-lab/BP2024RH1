extends Node2D


func _ready() -> void:
	if Global.culprit_found:
		$SceneSwitcherButton.NextSceneString = "Cäsars_big_brother"
	else:
		$SceneSwitcherButton.NextSceneString = "decrypting_caesar"
