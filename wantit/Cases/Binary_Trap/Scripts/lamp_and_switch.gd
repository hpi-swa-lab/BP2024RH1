extends Control

@onready var lamp: TextureRect = $VBoxContainer/Lamp
@onready var switch: TextureButton = $Switch
@onready var binary_label: Label = $"VBoxContainer/HBoxContainer/Binary Label"
@onready var weight_label: Label = $"VBoxContainer/HBoxContainer/Weight Label"
@onready var operation_label: Label = $"Operation Label"

var lamp_on_texture: Texture
var lamp_off_texture: Texture

var switch_on_texture: Texture
var switch_off_texture: Texture

var weight: int

signal updated

func _ready() -> void:
	lamp_on_texture = load("res://Cases/Binary_Trap/Assets/Minigame2/lamp_on.png")
	lamp_off_texture = load("res://Cases/Binary_Trap/Assets/Minigame2/lamp_off.png")

func update_lamp() -> void:
	lamp.texture = lamp_on_texture if switch.button_pressed else lamp_off_texture
	
func update_binary() -> void:
	binary_label.text = "1" if switch.button_pressed else "0"

func _on_switch_toggled(_toggled_on: bool) -> void:
	update_lamp()
	update_binary()
	emit_signal("updated")
	
func get_value() -> int:
	if switch.button_pressed:
		return weight
	else:
		return 0
		
func set_weight(number: int) -> void:
	weight = number
	weight_label.text = str(weight)
		
func refresh() -> void:
	switch.button_pressed = false
