extends Control

@export var MainText : String = "Lorem Ipsum"
@export var NameText : String = "Lorem Ipsum"
@export var ProfilePicture : Texture2D


func _ready():
 $popupDialogE/VBoxContainer/baseMenuScreen/NinePatchRect/InfoText/MainText.text = MainText
 $popupDialogE/VBoxContainer/baseMenuScreen/NinePatchRect/Name/ColorRect/NameText.text = NameText
 $popupDialogE/VBoxContainer/baseMenuScreen/Profile.set_texture(ProfilePicture)
