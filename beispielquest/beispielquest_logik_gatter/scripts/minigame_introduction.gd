extends Control


var explanation: Array[Label] 

@onready var explanation_start: Label = $explanation_start
@onready var explanation_connection: Label = $explanation_connection
@onready var explanation_try_start: Label = $explanation_try_start
@onready var explanation_try_start_2: Label = $explanation_try_start2
@onready var explanation_gatter: Label = $explanation_Gatter
@onready var explanation_ziel: Label = $explanation_Ziel
@onready var explanation_end: Label = $explanation_end

@onready var next_button: Button = $next_button
@onready var back_button: Button = $back_button


func _ready() -> void:
	explanation = [
		explanation_start,
		explanation_connection,
		explanation_try_start,
		explanation_try_start_2,
		explanation_gatter,
		explanation_ziel,
		explanation_end
	]




func _on_next_button_pressed() -> void:
	
	for x in range(explanation.size() - 1):
		if explanation[x].visible:
			explanation[x].hide()
			explanation[x + 1].show()
			back_button.show()
			
			if x == (explanation.size() - 2):
				next_button.hide()
			
			break


func _on_back_button_pressed() -> void:
	for x in range(explanation.size()):
		if explanation[x].visible:
			explanation[x].hide()
			explanation[x - 1].show()
			next_button.show()
			
			if (x - 1) == 0:
				back_button.hide()
				
			break


func _on_logik_gatter_level_introduction_start_1() -> void:
	if explanation_try_start.visible:
		explanation_try_start.hide()
		explanation_try_start_2.show()


func _on_logik_gatter_level_introduction_start_2() -> void:
	if explanation_try_start_2.visible:
			explanation_try_start_2.hide()
			explanation_gatter.show()
