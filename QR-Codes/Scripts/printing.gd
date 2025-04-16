extends Node2D

func _ready() -> void:
	if Global.Options == 1:
		Label.visible = true
	else: 
		%"QR-Code".visible = true
		%"Own Code".texture = Global.Tex
		%"Own Code".visible = true
