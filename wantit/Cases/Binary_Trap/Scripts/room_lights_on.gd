extends Location

@onready var cupboard: LocationSwitchButton = $Cupboard

var cupboard_texture_minigame5_completed: Texture
var cupboard_texture_minigame6a_completed: Texture
var cupboard_texture_minigame6b_completed: Texture
var cupboard_texture_key_collected: Texture

func _ready() -> void:
	cupboard_texture_minigame5_completed = load("res://Cases/Binary_Trap/Assets/Scene_Switcher/cupboard_woodpiece_closed.png")
	cupboard_texture_minigame6a_completed = load("res://Cases/Binary_Trap/Assets/Scene_Switcher/cupboard_safe_closed.png")
	cupboard_texture_minigame6b_completed = load("res://Cases/Binary_Trap/Assets/Scene_Switcher/cupboard_safe_open_key.png")
	cupboard_texture_key_collected = load("res://Cases/Binary_Trap/Assets/Scene_Switcher/cupboard_safe_open.png")

func set_cupboard_texture(texture: Texture) -> void:
	cupboard.texture_normal = texture

func _on_drawer_halfopen_pressed() -> void:
	%"Drawer halfopen".hide()
	%Lamps.hide()
	%"Drawer open".show()
