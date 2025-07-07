extends Location

func _ready() -> void:
	super._ready()
	
	var interaction_item = Item.new()
	interaction_item.item_name = "minigame_started"
	interaction_item.is_collectable = false
	item_found.emit(interaction_item)
	print("starting")
