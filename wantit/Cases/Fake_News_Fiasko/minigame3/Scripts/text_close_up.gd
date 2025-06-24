extends Control

@export var Profile_name: String
@export var Description: String

func _ready() -> void:
	%UserName.text = Profile_name
	%Description.text = Description
