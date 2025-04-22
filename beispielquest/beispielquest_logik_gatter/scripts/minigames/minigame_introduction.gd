extends Control

var ziel_input: bool = false

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
@onready var end_button: Button = $end_button

@onready var good_job: TextureRect = $Good_job

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

func _process(delta: float) -> void:
	if explanation_end.visible:
		end_button.show()


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


func _on_end_button_pressed() -> void:
	if ziel_input:
		# text das es geschaft wurde
		explanation_end.text = "Du hast es geschafft das Signal ist beim ZIel angekommen"
		#übergang zum richtigen minispiel
		good_job.show()
		explanation_end.hide()
	else: 
		#text das das signal noch nicht beim ziel ist
		explanation_end.text = "Das Signal ist noch nicht beim Ziel angekommen"


func _on_logik_gatter_level_introduction_ziel_input_false() -> void:
	ziel_input = false

func _on_logik_gatter_level_introduction_ziel_input_true() -> void:
	ziel_input = true


func _on_start_minigame_1_pressed() -> void:
			get_tree().change_scene_to_file("res://scenes/Minigames/Minigame_1.tscn")
