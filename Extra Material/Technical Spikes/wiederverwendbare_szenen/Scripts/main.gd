extends Node2D

@onready var wohnzimmer: Node2D = $Wohnzimmer


func _ready() -> void:
	#wird von hier nicht an wohnzimmer übergeben --> variablen müssen in wohnzimmer geändert werden 
	wohnzimmer.PLANT_SUS = false 
	wohnzimmer.PLANT_DEAD = true 
