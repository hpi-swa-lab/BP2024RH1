extends Location

func _ready():
	super._ready()

func _on_flour_sack_pressed() -> void:
	%"Flour Sack".z_index = 0
	%"Flour Sack".disabled = true
	%Key.show()
