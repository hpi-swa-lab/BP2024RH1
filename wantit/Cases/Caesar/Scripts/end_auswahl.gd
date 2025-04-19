extends Node2D

@export var Bild: CompressedTexture2D
@export var ButtonText: String
@export_enum("1:1", "2:2") var Ende: int

func _ready() -> void:
	print(Bild, ButtonText, Ende)
	%Sprite2D.texture = Bild
	%Sprite2D.position.y -= Bild.get_size().y/2 +20
	%Button.text = ButtonText
	await get_tree().process_frame #Warten weil die Geöße erst nach dem ersten Frame gesetzt 
	%Button.position.x -= %Button.size.x/2

func _on_button_pressed() -> void:
	Globals.Ende = Ende
