extends Resource

class_name Inventory

signal update

@export var slots: Array[InventorySlot]

func insert(item: InventoryItem): #wenn es das Item im Inventar schon gibt 
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else: # wenn es das Item im Inventar noch nicht gibt
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit() #das Signal senden
