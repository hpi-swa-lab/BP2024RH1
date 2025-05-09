extends Node

# is needed for helpsystem to know in which scene you are currently in by pressing the question mark
var current_scene: String

# var total_clues: int = 9
var all_clues_found_scene = load("res://Cases/Introduction_Case/scenes/bakery_kitchen.tscn")

var showroom_intro_shown: bool = false

#var hints: Dictionary[String, bool] = {
#	"key_collected" = false,
#	"door_inspected" = false,
#	"waffle_collected" = false,
	# office
#	"traces_in_office_inspected" = false,
#	"screwdriver_collected" = false,
#	"pliers_collected" = false,
#	"fingerprints_saved" = false,	
	# bakery
#	"flour_sack_inspected" = false,
# 	"traces_in_bakery_inspected" = false,
#}

var key_collected: bool = false
var door_inspected: bool = false
var waffle_collected: bool = false

var traces_in_bakery_inspected: bool = false
var flour_sack_inspected: bool = false

var inventory_explained: bool = false
var traces_in_office_inspected: bool = false
var screwdriver_collected: bool = false
var pliers_collected: bool = false
var fingerprints_saved: bool = false

func get_hints() -> Array:
	var hints: Array = [key_collected, door_inspected, waffle_collected, traces_in_bakery_inspected, flour_sack_inspected, traces_in_office_inspected, screwdriver_collected, pliers_collected, fingerprints_saved]
	print(hints)
	return hints
