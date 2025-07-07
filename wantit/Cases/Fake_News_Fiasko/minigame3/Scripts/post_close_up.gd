extends Control

@export var Post_picture: Texture2D
@export var Profile_name: String
@export var Description: String

func _ready() -> void:
	%Post.texture = Post_picture
	%UserName.text = Profile_name
	%Description.text = Description
