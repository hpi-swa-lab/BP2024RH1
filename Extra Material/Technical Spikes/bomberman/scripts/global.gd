extends Node

#festlegung: im normalen coordinaten sys x = width, y = height
var width = 31
var height = 19
#var brick_walls = 4
var TILE_SIZE = 16

var Player_1_score = 0
var Player_2_score = 0

enum PowerUpType {
	BOMB_UP, 
	FIRE_UP,
	SPEED_UP
}

#für die folgenden matrixen gilt:
	# 1 = dort ist ne wand
	# 0 = dort ist keine wand
var matrix = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
