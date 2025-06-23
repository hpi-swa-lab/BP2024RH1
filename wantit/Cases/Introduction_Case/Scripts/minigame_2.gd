extends Location

var LabelText: Dictionary = {}
var Buttons: Dictionary = {}
var Answers: Array[String] = []

var LevelsNum: int = 4
var Level: int = 0
var LevelAnswer: String

var errors: Array[bool] = []

var iteration_completed: bool = false

func _ready() -> void:
	super._ready()
	
	LabelText[0] = "Fingerabdruck eines Angestellten."
	LabelText[1] = "Es wurden mehrere Fingerabrücke am Safe gesichert."
	LabelText[2] = "Zur Ladentür des Waffelparadieses gehört ein Schlüssel mit dem Nummernstempel 2056."
	LabelText[3] = "Der Bäcker hat am 09. April Geburtstag."
	LabelText[4] = "Gestern waren 2 der 5 Angestellten bei 'Waffle Overflow' tätig."
	
	Answers.resize(LevelsNum + 1)
	errors.resize(LevelsNum + 1)
	
	for i in range(0, LevelsNum):
		Answers[i] = ""
		errors[i] = true
	
	for i in range(0, LevelsNum + 1):		
		var LevelArr = []
		Buttons[i] = LevelArr 
	
	initialize_buttons()
	load_level()

func _on_next_button_pressed() -> void:	
	if LevelAnswer != "":
		Answers[Level] = LevelAnswer
		errors[Level] = true
	else:
		errors[Level] = false
	
	if Level < LevelsNum:
		Level += 1
		load_level()
		
		if iteration_completed:
			prepare_for_answer_checking()
		
	else:
		iteration_completed = true
		prepare_for_answer_checking()

func prepare_for_answer_checking() -> void:
	%DataSelectionContainer.hide()
	
	for child in %DataCollectionGrid.get_children():
		%DataCollectionGrid.remove_child(child)
		
	check_Answers()
	
	%NextButton.hide()
	
func load_level():
	%NextButton.hide()
	%ClueLabel.text = LabelText[Level]
	create_level_buttons(Level)

func check_Answers():
	if has_no_errors():
		%SuccessLabel.show()
		%FinishButton.show()
	else:
		%ExplanationLabel.text = "Klicke auf die Fehlermeldung, um mehr zu erfahren!"
		initialize_messages()	

func has_no_errors() -> bool:
	for error in errors:
		if error:
			return false
	
	return true
		
func add_button(LevelNum: int, ButtonText: String, ButtonTex: CompressedTexture2D, Answer: String) -> void:
	var newButton = Button.new()
	
	if ButtonText != null and ButtonTex == null:
		newButton.text = ButtonText
	else:
		newButton.icon = ButtonTex
	
	newButton.pressed.connect(self.button_pressed.bind(Answer))
	Buttons[LevelNum].append(newButton)

func button_pressed(Answer: String):
	LevelAnswer = Answer
	%NextButton.show()
	if Level == LevelsNum:
		%NextButton.text = "Überprüfen"

func create_level_buttons(LevelNum: int):
	for child in %DataCollectionGrid.get_children():
		%DataCollectionGrid.remove_child(child)
	if LevelNum <= LevelsNum:
		var LevelButtons = Buttons[LevelNum]
		for button in LevelButtons:
			%DataCollectionGrid.add_child(button)

func initialize_buttons():
	add_button(0, "'Fingerabdruck'", null, "[WARNING] Wert 'Fingerabdruck' nicht präzise genug.")
	add_button(0, "Ich bin 5 Abdrücke", load("res://Cases/Introduction_Case/assets/minigame2/photo_fingerprints.png"), "[ERROR] Ein Bild erwartet - mehrere erhalten")
	add_button(0, "Ich bin 1 Abdruck", load("res://Cases/Introduction_Case/assets/minigame2/single_fingerprint.png"), "")
	
	add_button(1, "Ich bin 1 Abdruck", load("res://Cases/Introduction_Case/assets/minigame2/single_fingerprint.png"), "[ERROR] Mehrere Bilder erwartet - eins erhalten")
	add_button(1, "Ich bin 5 Abdrücke", load("res://Cases/Introduction_Case/assets/minigame2/photo_fingerprints.png"), "")
	add_button(1, "'Fingerabdruck'", null, "[WARNING] Wert 'Fingerabdruck' nicht präzise genug.")
	
	add_button(2, "", load("res://Cases/Introduction_Case/assets/minigame2/key2056.png"), "")
	add_button(2, "2056", null, "[ERROR] Nummer erhalten - Bild erwartet")
	add_button(2, "", load("res://Cases/Introduction_Case/assets/minigame2/key.png"), "[ERROR] Keine Tür ohne Nummer gefunden")
	
	add_button(3, "09.04", null, "")
	add_button(3, "9.4", null, "[ERROR] Datumsformat nicht gültig - TT.MM. erwartet")
	add_button(3, "April", null, "[WARNING] Wert 'April' nicht präzise genug")
	add_button(3, "9", null, "[WARNING] Wert '9' nicht präzise genug")
	add_button(3, "Ich bin ein Kuchen", load("res://Cases/Introduction_Case/assets/minigame2/cake.png"), "[ERROR] Datum erwartet - Bild erhalten")
	
	add_button(4, "2/5", null, "")
	add_button(4, "2", null, "[ERROR] '2' stimmt nicht mit Protokolldaten überein")
	add_button(4, "5", null, "[ERROR] '5' stimmt nicht mit Protokolldaten überein")
	add_button(4, "20%", null, "[WARNING] Wert '20%' nicht präzise genug")	

func initialize_messages() -> void:
	var index: int = 0
	
	while index <= LevelsNum:
		if Answers[index] != "" && Answers[index] != null: # Only a QUICK FIX: If some answer is incorrect and the correct answer for task 5 is chosen, there is an error, that message.text is null
			var container: HBoxContainer = HBoxContainer.new()
			container.add_theme_constant_override("separation", 200)
			
			var message_button: Button = create_error_message(Answers[index])
			message_button.pressed.connect(self.on_error_message_button_pressed.bind(index))
			
			container.add_child(create_label(LabelText[index]))
			container.add_child(message_button)
			
			%ErrorTable.add_child(container)
		
		index += 1
		
func on_error_message_button_pressed(level_index: int) -> void:
	for child in %ErrorTable.get_children():
		child.queue_free()
	
	%DataSelectionContainer.show()
	
	Level = level_index
	Answers[level_index] = ""
	
	load_level()
		
func create_error_message(buttonText) -> Button:
	var message: Button = Button.new()
	message.text = buttonText
	
	return message
	
func create_label(labelText: String) -> Label:
	var label: Label = Label.new()
	
	label.custom_minimum_size = Vector2(270, 0)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.add_theme_color_override("font_color", Color(0.0, 0.0, 0.0))

	label.text = labelText
	
	return label

func _on_finish_button_pressed() -> void:
	print("Minigame2 completed")
	var interaction_item = Item.new()
	interaction_item.item_name = "Minigame2 completed"
	interaction_item.is_collectable = false
	item_found.emit(interaction_item)
