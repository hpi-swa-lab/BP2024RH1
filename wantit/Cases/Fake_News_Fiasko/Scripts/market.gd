extends Location

func _ready() -> void:
	super._ready()

	await DialogueManager.dialogue_ended
	var interaction_item = Item.new()
	interaction_item.item_name = "Salesperson"
	interaction_item.is_collectable = false
	item_found.emit(interaction_item)
