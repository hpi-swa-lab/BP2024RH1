extends Location

func _ready() -> void:
	super._ready()
	await get_tree().create_timer(2.0).timeout
	_on_location_switch_requested("Restaurant Dining Hall Post")
