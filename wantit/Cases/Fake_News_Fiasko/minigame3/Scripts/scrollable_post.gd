extends post

@export var Post_picture: Texture2D

func _ready() -> void:
	%TextureRect.texture = Post_picture
	%ProfileName.text = Profile_name
