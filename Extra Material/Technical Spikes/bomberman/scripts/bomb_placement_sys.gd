extends Node

class_name BombPlacementSys

const BOMB_SCENE = preload("res://scenes/bombs/Bomb.tscn")
const TILE_SIZE = 16

var player : Player = null
var bombs_placed = 0 


func _ready() -> void:
	player = get_parent()

func place_bomb():
	if bombs_placed == player.max_bombs_at_once:
		return
	
	var bomb = BOMB_SCENE.instantiate()
	var player_position = player.position
	
	#folgede variable ist dafü+r da die bombe in blick richtung zu platzieren
	var orientation = player.last_movement_direction * TILE_SIZE	
	
	#damit bomben in mitte von tile muss + tile/2 weil da die mitte ist
	var bomb_position = Vector2((floor(player_position.x / TILE_SIZE) * TILE_SIZE) + TILE_SIZE/2 + orientation.x, \
		(floor(player_position.y / TILE_SIZE) * TILE_SIZE) + TILE_SIZE/2 + orientation.y )
	
	#berechnung ob bombe in wand platziert wird
	#umwandlung bomb_position in coordinaten für matrix aus global script
	var index_x = floor(bomb_position.x / TILE_SIZE)
	var index_y = floor(bomb_position.y / TILE_SIZE)
	if Global.matrix[index_x][index_y]:
		bomb_position = bomb_position - orientation
	
	
	bomb.explosion_size = player.explosion_size
	bomb.position = bomb_position
	#get_tree().root.add_child(bomb)
	get_tree().root.add_child(bomb)
	bombs_placed += 1 
	bomb.tree_exiting.connect(on_bomb_exploded)
	
func on_bomb_exploded():
	bombs_placed -= 1	

	
