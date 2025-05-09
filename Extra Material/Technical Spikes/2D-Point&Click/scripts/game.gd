extends TextureRect

@export var inventory: Inventory # damit game Zugriff auf Inventar hat

func collect(item):
	inventory.insert(item)
