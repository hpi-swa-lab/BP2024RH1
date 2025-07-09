extends Minigame

@onready var on_or_off_label: Label = $"on_or_off label"
@onready var digit_label: Label = $"digit label"
@onready var switch: TextureButton = $switch
@onready var background: TextureRect = $Background
@onready var back_button: LocationSwitchButton = $BackButton

var background_lightOn_texture: Texture
var background_lightOff_texture: Texture
var requested_location_lightsOn: String
var requested_location_lightsOff: String

func _ready() -> void:
	super._ready()
	on_or_off_label.text = "Aus"
	digit_label.text = "0"
	
	background_lightOn_texture = load("res://Cases/Binary_Trap/Assets/Minigame1/minigame1_closeUp_lightOn.png")
	background_lightOff_texture = load("res://Cases/Binary_Trap/Assets/Minigame1/minigame1_closeUp_lightOff.png")
	
	requested_location_lightsOn = "Room LightsOn"
	requested_location_lightsOff = "Room LightsOff"

func update_display() -> void:
	light_on() if switch.button_pressed else light_off()
	
func light_on() -> void:
	on_or_off_label.text = "An"
	on_or_off_label.add_theme_color_override("font_color", Color.BLACK)
	digit_label.text = "1"
	digit_label.add_theme_color_override("font_color", Color.BLACK)
	
	background.texture = background_lightOn_texture
	back_button.requested_location_name = requested_location_lightsOn
	
func light_off() -> void:
	on_or_off_label.text = "Aus"
	on_or_off_label.add_theme_color_override("font_color", Color.WHITE)
	digit_label.text = "0"
	digit_label.add_theme_color_override("font_color", Color.WHITE)
	
	background.texture = background_lightOff_texture
	back_button.requested_location_name = requested_location_lightsOff

func _on_switch_toggled(_toggled_on: bool) -> void:
	update_display()
