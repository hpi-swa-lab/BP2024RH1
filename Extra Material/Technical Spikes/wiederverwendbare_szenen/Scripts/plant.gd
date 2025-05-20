extends Control



@onready var plant_normal: Button = $Plant_normal
@onready var plant_sus: Button = $Plant_sus
@onready var plant_dead: Button = $Plant_dead
@onready var plant_dead_and_sus: Button = $Plant_dead_and_sus



func _ready() -> void:
	var room = get_parent()
	var PLANT_SUS = room.PLANT_SUS
	var PLANT_DEAD = room.PLANT_DEAD
	
	if PLANT_SUS && PLANT_DEAD:
		plant_normal.disabled = true
		plant_normal.visible = false
		
		plant_dead_and_sus.disabled = false 
		plant_dead_and_sus.visible = true 
		
	elif PLANT_SUS:
		plant_normal.disabled = true
		plant_normal.visible = false
		
		plant_sus.disabled = false 
		plant_sus.visible = true 
		
	elif PLANT_DEAD:
		plant_normal.disabled = true
		plant_normal.visible = false
		
		plant_dead.disabled = false 
		plant_dead.visible = true 
	
	if PLANT_SUS:
		#spawn_hinweis_picture_normalPlant()
		pass
