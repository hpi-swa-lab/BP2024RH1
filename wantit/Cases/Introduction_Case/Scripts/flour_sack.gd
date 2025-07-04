extends Item

func _ready():
	super._ready()

func _on_flour_sack_pressed() -> void:
	if not is_found:
		set_found()

func set_found() -> void:
	%"Flour Sack".z_index = 0
	%"Flour Sack".disabled = true
	if not %Key.is_found:
		%Key.show()
