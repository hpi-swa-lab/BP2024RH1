extends Node2D

@export var Subject: String
@export var FirstGamePicture: Texture2D
@export var SecondGamePicture: Texture2D

func _ready() -> void:
	%Label.text = "In diesem Fall hast du etwas über " + Subject + " gelernt"
	%FirstGame.texture = resize_image(FirstGamePicture)
	%SecondGame.texture = resize_image(SecondGamePicture)
	
func resize_image(Img: Texture2D):
	var tex = Img.get_image()
	tex.resize(400, 225, Image.INTERPOLATE_LANCZOS)
	var newTex = ImageTexture.create_from_image(tex)
	return newTex

func _on_button_pressed() -> void:
	DialogueManager.show_dialogue_balloon(load ("res://dialogue_balloons/complete_case.dialogue"), "complete_case")