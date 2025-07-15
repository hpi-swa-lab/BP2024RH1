extends Location
class_name Minigame

func _ready() -> void:
	super._ready()

func export_location_analytics():
	print("Adding minigame")
	Analytics.add_scene_analytics(location_name, "Minigame", GlobalTimer.get_time(location_name))
