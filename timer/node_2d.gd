extends Node2D

var Timer1 = "Spielstart"
var Timer2 = "Minispiel"

func _ready() -> void:
	GlobalTimer.start_timer(Timer1)

func _on_start_pressed() -> void:
	GlobalTimer.start_timer(Timer2)

func _on_end_pressed() -> void:
	GlobalTimer.end_timer(Timer2)

func _on_button_pressed() -> void:
	GlobalTimer.end_timer(Timer1)
	print(GlobalTimer.print_time(Timer1), GlobalTimer.print_time(Timer2))
