extends Button

@export var Text: String
@export var NextSceneString: String

func _ready() -> void:
	self.text = Text

func _on_pressed() -> void:
	#SceneSwitcher.switch_scene("res://Scenes/" + NextSceneString + ".tscn")
	SceneSwitcher.switch_to_scene("res://Scenes/" + NextSceneString + ".tscn")
