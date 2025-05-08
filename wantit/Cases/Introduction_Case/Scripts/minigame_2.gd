extends Node2D

var LabelText = {}
var Buttons = {}
var Answers = []

var LevelsNum = 4
var Level: int = 0
var correctAnswers = true
var LevelAnswer: String

func _ready() -> void:
	LabelText[0] = "Fingerabdruck eines \nAngestellten."
	LabelText[1] = "Es wurden mehrere \nFingerabrücke am Safe \ngesichert."
	LabelText[2] = "Zur Ladentür des \nWafelparadieses gehört \nein Schlüssel mit dem \nNummernstempel 2056."
	LabelText[3] = "Der Bäcker hat am \n09. April Geburtstag."
	LabelText[4] = "Gestern waren 2 der 5 \nAngestellten bei \n'Waffle Overflow' tätig."
	
	for i in range(0, LevelsNum + 1):
		var LevelArr = []
		Buttons[i] = LevelArr
	
	initialize_buttons()
	load_level()

func _on_next_button_pressed() -> void:
	if Level < LevelsNum:
		Level += 1
		load_level()
	else:
		check_Answers()
		%nextButton.hide()
	
func load_level():
	%nextButton.hide()
	%ClueLabel.text = LabelText[Level]
	create_level_buttons(Level)
	if LevelAnswer != "":
		Answers.append(LevelAnswer)
		correctAnswers = false

func check_Answers():
	for child in %Buttons.get_children():
		%Buttons.remove_child(child)
	if correctAnswers:
		%Label.text = "No Errors or Warnings, do cool stuff now"
		Globals.OfficeDialogue = "res://dialogue/dialogue.dialogue"
		Globals.OfficeDialogueStart = "finish"
		Globals.OfficeDialogueDone = false
		SceneSwitcher.switch_scene("res://Scenes/office.tscn")
	else:
		var AnswerTexts: String = ""
		for Answer in Answers:
			AnswerTexts += Answer + "\n"
		%Label.text = AnswerTexts
		%RestartButton.show()
	
func add_button(LevelNum: int, ButtonText: String, ButtonPos: Vector2, ButtonTex: CompressedTexture2D, ButtonScale: Vector2, Answer: String):
	var newButton = Button.new()
	
	newButton.position = ButtonPos
	if ButtonText != null and ButtonTex == null:
		newButton.text = ButtonText
	else:
		newButton.icon = ButtonTex
		newButton.scale = ButtonScale
	
	newButton.pressed.connect(self.button_pressed.bind(Answer))
	Buttons[LevelNum].append(newButton)

func button_pressed(Answer: String):
	LevelAnswer = Answer
	%nextButton.show()
	if Level == LevelsNum:
		%nextButton.text = "Überprüfen"

func create_level_buttons(LevelNum: int):
	for child in %Buttons.get_children():
		%Buttons.remove_child(child)
	if LevelNum <= LevelsNum:
		var LevelButtons = Buttons[LevelNum]
		for button in LevelButtons:
			%Buttons.add_child(button)

func initialize_buttons():
	add_button(0, "'Fingerabdruck'", Vector2(800, 200), null, Vector2(1, 1), "[WARNING] Wert 'Fingerabdruck' nicht präzise genug.")
	add_button(0, "Ich bin 5 Abdrücke", Vector2(500, 100), null, Vector2(1, 1), "[ERROR] Ein Bild erwartet - mehrere erhalten")
	add_button(0, "Ich bin 1 Abdruck", Vector2(700, 350), null, Vector2(1, 1), "")
	
	add_button(1, "Ich bin 1 Abdruck", Vector2(600, 200), null, Vector2(1, 1), "[ERROR] Mehrere Bilder erwartet - eins erhalten")
	add_button(1, "Ich bin 5 Abdrücke", Vector2(830, 120), null, Vector2(1, 1), "")
	add_button(1, "'Fingerabdruck'", Vector2(500, 280), null, Vector2(1, 1), "[WARNING] Wert 'Fingerabdruck' nicht präzise genug.")
	
	add_button(2, "2056", Vector2(760, 200), null, Vector2(1, 1), "")
	add_button(2, "6382", Vector2(600, 300), null, Vector2(1, 1), "[ERROR] Keine Tür mit der Nummer '6382' gefunden")
	add_button(2, "Ich bin ein Schlüssel", Vector2(500, 150), null, Vector2(1, 1), "[ERROR] Nummer erwartet - Bild erhalten")
	
	add_button(3, "09.04", Vector2(600, 200), null, Vector2(1, 1), "")
	add_button(3, "9.4", Vector2(850, 180), null, Vector2(1, 1), "[ERROR] Datumsformat nicht gültig - TT.MM. erwartet")
	add_button(3, "April", Vector2(480, 350), null, Vector2(1, 1), "[WARNING] Wert 'April' nicht präzise genug")
	add_button(3, "9", Vector2(500, 100), null, Vector2(1, 1), "[WARNING] Wert '9' nicht präzise genug")
	add_button(3, "Ich bin ein Kuchen", Vector2(750, 320), null, Vector2(1, 1), "[ERROR] Nummer erwartet - Bild erhalten")
	
	add_button(4, "2/5", Vector2(600, 300), null, Vector2(1, 1), "")
	add_button(4, "2", Vector2(500, 100), null, Vector2(1, 1), "[ERROR] '2' stimmt nicht mit Protokolldaten überein")
	add_button(4, "5", Vector2(900, 250), null, Vector2(1, 1), "[ERROR] '5' stimmt nicht mit Protokolldaten überein")
	add_button(4, "20%", Vector2(700, 120), null, Vector2(1, 1), "[WARNING] Wert '20%' nicht präzise genug")

func _on_restart_button_pressed() -> void:
	correctAnswers = true
	Answers = []
	Level = 0
	LevelAnswer = ""
	%RestartButton.hide()
	%Label.text = ""
	load_level()
