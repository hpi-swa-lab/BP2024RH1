extends Control

signal display_question_mark

@onready var hint_text = $Panel/Hint_text


func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	match GlobalFirstScene.level_parameters.scene:
		"office":
			load_office_hint()
		"salesroom":
			load_salesroom_hint()
		"safe_in_office":
			load_safe_in_office_hint()
		"bakery":
			load_bakery_hint()
		_:
			pass
		


func load_salesroom_hint():
	if !GlobalFirstScene.level_parameters.waffle:
		hint_text.text = "Was liegt denn da auf der Theke?"
	elif GlobalFirstScene.level_parameters.key:
		hint_text.text = "Ich sollte mir die Ladentür noch einmal ansehen."
	else:
		hint_text.text = "Ziehe den Schlüssel auf die Ladentür."

func load_office_hint():
	if !GlobalFirstScene.level_parameters.traces_in_office:
		hint_text.text = "Was sind denn das für Spuren auf dem Boden?"
	elif !GlobalFirstScene.level_parameters.screwdriver and !GlobalFirstScene.level_parameters.plier or !GlobalFirstScene.level_parameters.fingerprints:
		hint_text.text = "Ich sollte mir den Safe mal genauer anschauen."
	else:
		hint_text.text = "Hier scheint nichts auffälliges mehr zu sein" 
	
func load_safe_in_office_hint():
	if !GlobalFirstScene.level_parameters.screwdriver and !GlobalFirstScene.level_parameters.plier:
		hint_text.text = "Was sind denn das für Werkzeuge?"
	elif !GlobalFirstScene.level_parameters.fingerprints:
		hint_text.text = "Sind das Fingerabdrücke am Safe?"
	else:
		"Mit dem Safe bin ich soweit fertig."
	
func load_bakery_hint():
	if !GlobalFirstScene.level_parameters.traces_in_bakery:
		hint_text.text = "Was sind denn das für Spuren auf dem Boden?"
	else:
		hint_text.text = "In der Backstube sehe ich keine Auffälligkeiten mehr"


func _on_close_btn_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton: #is_action_pressed("left_click"):
		visible = false
		emit_signal("display_question_mark")
	# delay until helpscreen can be used again (einblenden or disable) emit signal
		print("close_btn") 

		
