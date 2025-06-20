extends Control

var pictures = [
	preload("res://Cases/Fake_News_Fiasko/Assets/minigame1/securityFootage_follower1.png"),
	preload("res://Cases/Fake_News_Fiasko/Assets/minigame1/securityFootage_follower2.png"),
	preload("res://Cases/Fake_News_Fiasko/Assets/minigame1/securityFootage_follower3.png"),
	preload("res://Cases/Fake_News_Fiasko/Assets/minigame1/securityFootage_follower4.png")
]
var cur_index = 0

@onready var cur_pic = $TextureRect
@onready var back_btn = $Zurück
@onready var next_btn = $Weiter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	cur_pic.texture = pictures[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cur_pic.texture == pictures[0]:
		back_btn.visible = false
	else:
		back_btn.visible = true
	if cur_pic.texture == pictures[3]:
		next_btn.visible = false
	else:
		next_btn.visible = true



func _on_weiter_pressed() -> void:
	#var prefix = "res://Assets/securityFootage_follower"
	#var suffix = ".png"
	#print(cur_pic)
	#var number = cur_pic.lstrip(prefix).rstrip(suffix)
	#number += 1
	#cur_pic = prefix + str(number) + suffix
	cur_index += 1
	cur_pic.texture = pictures[cur_index]


func _on_zurück_pressed() -> void:
	cur_index -= 1
	cur_pic.texture = pictures[cur_index]


func _on_security_footage_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		visible = true



func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not cur_pic.get_global_rect().has_point(event.position):
			visible = false
