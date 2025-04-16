extends Control

class_name Helpsys

@onready var questionmark: Button = $Questionmark
@onready var hints: Control = $Hints

@onready var timer_hint_2: Timer = $Timer_Hint_2
@onready var timer_hint_3: Timer = $Timer_Hint_3

@onready var hint_1: Label = $Hints/VBoxContainer/HBoxContainer/VBoxContainer/Hint_1
@onready var hint_2: Label = $Hints/VBoxContainer/HBoxContainer/VBoxContainer/Hint_2
@onready var hint_3: Label = $Hints/VBoxContainer/HBoxContainer/VBoxContainer/Hint_3

@export var hint_1_text: String
@export var hint_2_text: String
@export var hint_3_text: String

@export var Timer_hint_2_time: float = 90
@export var Timer_hint_3_time: float = 120


func _ready() -> void:
	hint_1.text = hint_1_text 
	hint_2.text = hint_2_text
	hint_3.text = hint_3_text
	
	timer_hint_2.wait_time = Timer_hint_2_time
	timer_hint_3.wait_time = Timer_hint_3_time
	
	timer_hint_2.start()
	timer_hint_3.start()



func _on_questionmark_pressed() -> void:
	questionmark.hide()
	hints.show()

func _on_close_pressed() -> void:
	questionmark.show()
	hints.hide()


func _on_timer_hint_2_timeout() -> void:
	hint_2.show()
	print("2")

func _on_timer_hint_3_timeout() -> void:
	hint_3.show()
	print("3")
