extends Location

@onready var flour_sack = get_node_or_null("Flour Sack")

func _ready() -> void:
	if flour_sack:
		flour_sack.pressed.connect(func(): _on_flour_sack_pressed(flour_sack))
	else:
		push_error("Flour Sack node not found!")

func _on_flour_sack_pressed(item: TextureButton) -> void:
	#disable_item(item)
	flour_sack.z_index = 0
	%Key.show()
