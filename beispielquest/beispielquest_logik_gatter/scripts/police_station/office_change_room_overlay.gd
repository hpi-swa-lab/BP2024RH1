extends Control

@export var OFFICE: bool = true
@export var BIG_OFFICE: bool = true 
@export var HEAD_OFFICE: bool = true
@export var TECH_ROOM: bool = true
@export var FLUR: bool = true
@export var KITCHEN: bool = true

@onready var office: change_room_button = $Office
@onready var big_office: change_room_button = $Big_Office
@onready var head_office: change_room_button = $Head_Office
@onready var tech_room: change_room_button = $Tech_room
@onready var flur: change_room_button = $Flur
@onready var kitchen: change_room_button = $Kitchen



func _ready() -> void:
	office.show()
	if !OFFICE:
		office.hide()
	if !BIG_OFFICE:
		big_office.hide()
	if !HEAD_OFFICE:
		head_office.hide()
	if !TECH_ROOM:
		tech_room.hide()
	if !FLUR:
		flur.hide()
	if !KITCHEN:
		kitchen.hide()
