extends Location

@onready var flour_sack = get_node_or_null("Flour Sack")

func _ready():
	super._ready()

func _on_flour_sack_pressed() -> void:
	#disable_item(item)
	flour_sack.z_index = 0
	flour_sack.disabled = true
	%Key.show()
