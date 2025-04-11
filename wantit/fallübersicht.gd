extends Node2D

@export var Button_pos: Vector2
var selected_Case: String

func _ready() -> void:
	%Open_Caseboard.position = Button_pos
	add_Case("Cäsar")
	add_Case("Test123")
	for i in range(10):
		add_Case("a")


func _on_open_caseboard_pressed() -> void:
	%Caseboard_UI.visible = true
	%Open_Caseboard.visible = false


func _on_back_button_pressed() -> void:
	%Caseboard_UI.visible = false
	print("tada")

func add_Case(CaseName: String) -> void:		#A Case Type should also be added here or an alternativ connection how cases are loaded
	var new_Case = Button.new()
	new_Case.text = CaseName
	new_Case.custom_minimum_size.y = 40
	new_Case.pressed.connect(self.Case_button_pressed.bind(CaseName))
	%VBoxContainer.add_child(new_Case)

func Case_button_pressed(CaseName: String) -> void:
	%SelectButton.visible = true
	selected_Case = CaseName
	
func _on_select_button_pressed() -> void:
	if selected_Case != null:
		print(selected_Case) # Here should be the connection to load the Case
