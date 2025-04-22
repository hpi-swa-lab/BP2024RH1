extends Control


@onready var office: Control = $"../Office"
@onready var head_office: Control = $"../HeadOffice"
@onready var big_office: Control = $"../BigOffice"
@onready var tech_room: Control = $"../TechRoom"
@onready var kitchen: Control = $"../Kitchen"



func _on_office_button_pressed() -> void:
	print("0")

	hide_all_rooms()
	office.show()

func _on_head_office_button_pressed() -> void:
	print("1")
	hide_all_rooms()
	head_office.show()


func _on_big_office_button_pressed() -> void:
	print("4")
	hide_all_rooms()
	big_office.show()


func _on_tech_room_button_pressed() -> void:
	print("5")
	hide_all_rooms()
	tech_room.show()


func _on_kitchen_button_pressed() -> void:
	print("6")
	hide_all_rooms()
	kitchen.show()


func hide_all_rooms() -> void:
	office.hide()
	head_office.hide()
	big_office.hide()
	tech_room.hide()
	kitchen.hide()
