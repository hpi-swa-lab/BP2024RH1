extends Location

var label_settings: LabelSettings = LabelSettings.new()

func _ready() -> void:
	super._ready()
	DialogueManager.get_current_scene = func():
		return self

func change_example():
	%ExampleWord.text = "TELR"

func show_alphabet():
	%ExampleWord.hide()
	%Alphabet.show()
	
func move_example_word():
	%ExampleWord.show()
	%ExampleWord.text = "T  E  L  R"
	label_settings.font_size = 30
	%ExampleWord.label_settings = label_settings
	%ExampleWord.position = Vector2(125, 349)
	
func show_encrypted_alphabet():
	%EncryptedAlphabet.show()
	
func add_text():
	%Alphabet.position = Vector2(50, 257)
	%EncryptedAlphabet.position = Vector2(50, 349)
	%ExampleWord.position = Vector2(50, 349)
	%Explanation1.show()
	%Explanation2.show()
	%Explanation3.show()
	
	label_settings.font_color = Color("#d3c308")
	%ExampleWord.label_settings = label_settings
	
	DialogueManager.get_current_scene = func():
		var current_scene: Node = Engine.get_main_loop().current_scene
		if current_scene == null:
			current_scene = Engine.get_main_loop().root.get_child(Engine.get_main_loop().root.get_child_count() - 1)
		return current_scene
	
func reset_tutorial():
	%Explanation1.hide()
	%Explanation2.hide()
	%Explanation3.hide()
	
	%ExampleWord.show()
	%ExampleWord.text = "TELLER"
	label_settings.font_size = 90
	label_settings.font_color = Color.BLACK
	%ExampleWord.label_settings = label_settings
	%ExampleWord.position = Vector2(400, 240)
	
	%EncryptedAlphabet.hide()
	%EncryptedAlphabet.position = Vector2(125, 349)
	
	%Alphabet.hide()
	%Alphabet.position = Vector2(125, 257)
