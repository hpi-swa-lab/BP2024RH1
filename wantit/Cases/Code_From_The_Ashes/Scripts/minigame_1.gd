extends Location

func _on_default_minigame_minigame_completed() -> void:
	DialogueManager.show_dialogue_balloon_scene(
			location_dialogue.baloon_type,
			location_dialogue.dialogue_resource,
			"caesar_decrypted")
	await DialogueManager.dialogue_ended
			
	var interaction_item = Item.new()
	interaction_item.item_name = "Minigame1 completed"
	item_found.emit(interaction_item)
