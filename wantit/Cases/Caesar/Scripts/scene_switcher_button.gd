extends Button

@export var Text: String
@export var NextSceneString: String

func _ready() -> void:
	self.text = Text

func _on_pressed() -> void:
	var Folder: String = ""
	if NextSceneString == "office":
		SceneSwitcher.switch_scene("res://Scenes/office.tscn")
	elif Globals.selectedCase != null:
		Folder = "Cases/" + Globals.selectedCase.CaseName
	SceneSwitcher.switch_scene("res://" + Folder + "/Scenes/" + NextSceneString + ".tscn")
