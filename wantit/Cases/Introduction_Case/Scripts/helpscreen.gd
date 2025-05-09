extends Control

signal display_question_mark

@onready var hint_text = $MarginContainer/Hint_text


func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	match CaseManager.CaseGlobals.current_scene:
		"bakery_office":
			load_office_hint()
		"showroom":
			load_showroom_hint()
		"safe_close_up":
			load_safe_in_office_hint()
		"bakery_kitchen":
			load_bakery_hint()
		_:
			pass
		


func load_showroom_hint():
	if !CaseManager.CaseGlobals.waffle_collected:
		hint_text.text = "Was liegt denn da auf der Theke?"
	elif !CaseManager.CaseGlobals.key_collected:
		hint_text.text = "Ich sollte mir die Ladentür noch einmal ansehen."
	else:
		hint_text.text = "Ziehe den Schlüssel auf die Ladentür."

func load_office_hint():
	if !CaseManager.CaseGlobals.traces_in_office_inspected:
		hint_text.text = "Was sind denn das für Spuren auf dem Boden?"
	elif (!CaseManager.CaseGlobals.screwdriver_collected or !CaseManager.CaseGlobals.pliers_collected or !CaseManager.CaseGlobals.fingerprints_saved):
		hint_text.text = "Ich sollte mir den Safe mal genauer anschauen."
	else:
		hint_text.text = "Hier scheint nichts auffälliges mehr zu sein" 
	
func load_safe_in_office_hint():
	if (!CaseManager.CaseGlobals.screwdriver_collected or !CaseManager.CaseGlobals.pliers_collected):
		hint_text.text = "Was sind denn das für Werkzeuge?"
	elif !CaseManager.CaseGlobals.fingerprints_saved:
		hint_text.text = "Sind das Fingerabdrücke am Safe?"
	else:
		hint_text.text = "Mit dem Safe bin ich soweit fertig."
	
func load_bakery_hint():
	if !CaseManager.CaseGlobals.traces_in_bakery_inspected:
		hint_text.text = "Was sind denn das für Spuren auf dem Boden?"
	else:
		hint_text.text = "In der Backstube sehe ich keine Auffälligkeiten mehr"


func _on_close_btn_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton: #is_action_pressed("left_click"):
		visible = false
		emit_signal("display_question_mark")
	# delay until helpscreen can be used again (einblenden or disable) emit signal
		print("close_btn") 

		
