extends Location

func _ready() -> void:
	super._ready()

func _on_drawer_halfopen_pressed() -> void:
	%"Drawer halfopen".hide()
	%Lamps.hide()
	%"Drawer open".show()
