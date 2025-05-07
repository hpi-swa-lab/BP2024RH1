extends Button

@export var NextSceneString: String

func _on_pressed() -> void:
	var Folder: String = ""
	if Globals.selectedCase != null:
		Folder = "Cases/" + Globals.selectedCase.CaseName
	SceneSwitcher.switch_scene("res://" + Folder + "/Scenes/" + NextSceneString + ".tscn")
