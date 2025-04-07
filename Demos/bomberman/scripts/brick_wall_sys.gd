extends Node

@export var Speed_Up_Count = 20
@export var Fire_Up_Count = 20
@export var Bomb_Up_Count = 20

var height = Global.height
var width = Global.width
var TILE_SIZE = Global.TILE_SIZE

const BRICK_WALL = preload("res://scenes/Brick_Wall.tscn")
const BOMB_UP = preload("res://Resources/bomb_up.tres")
const FIRE_UP = preload("res://Resources/fire_up.tres")
const SPEED_UP = preload("res://Resources/speed_up.tres")




func _ready() -> void:
	
	Global.matrix = []
	
	#matrix instanziieren für tilemap layer
	for x in range(width):
		Global.matrix.append([])
		for y in range(height):
			if (x == 0) || (y == 0) || (x%2 == 0) && (y%2 == 0) || (x == width - 1) || (y == height - 1):
				Global.matrix[x].append(1)
				continue
			#gleiches für player position implementieren damit keine walls um player gespawnt werden 
			Global.matrix[x].append(0)
			
	#brickwalls generieren 
	
	#brickwalls mit bomb_up power up
	for i in range(Bomb_Up_Count):
		spawn_brick_wall_with(0)
	
	#brickwalls mit fire_up power up
	for i in range(Fire_Up_Count):
		spawn_brick_wall_with(1)
	
	#brickwalls mit speed_up power up
	for i in range(Speed_Up_Count):
		spawn_brick_wall_with(2)
	
func spawn_brick_wall_with(power_up_type: Global.PowerUpType):
	var index_x = 0
	var index_y = 0
		
	index_x = ((randi() % (width - 1)) + 1) #rdn num zwischen 1 und 30
	index_y = ((randi() % (height - 1)) + 1)  #rdn num zwischen 1 und 18
	#schleife um indexe gegebenenfalls zuverschieben, damit an der stelle net schon ne wand ist
	if (Global.matrix[index_x][index_y]):
		for lenght in range(floor(height / 2) - 1):
			for j in range((lenght * 2) + 1):
				if ! (((index_x - lenght + j) > width - 1) || ((index_y + lenght) > height - 1) || (Global.matrix[index_x - lenght + j][index_y + lenght])):
					create_brick_wall_at_with_pu(index_x - lenght + j, index_y + lenght, power_up_type)
					return
					
				if ! (((index_x - lenght + j) > width - 1) || ((index_y - lenght) > height - 1) || (Global.matrix[index_x - lenght + j][index_y - lenght])):
					create_brick_wall_at_with_pu(index_x - lenght + j, index_y - lenght, power_up_type)
					return
					
				if ! (((index_x + lenght) > width - 1) ||  ((index_y - lenght + j) > height - 1) || (Global.matrix[index_x + lenght][index_y - lenght + j])):
					create_brick_wall_at_with_pu(index_x + lenght, index_y - lenght + j, power_up_type)
					return
					
				if ! (((index_x - lenght) > width - 1) ||  ((index_y - lenght + j) > height - 1) || (Global.matrix[index_x - lenght][index_y - lenght + j])):
					create_brick_wall_at_with_pu(index_x - lenght, index_y - lenght + j, power_up_type)
					return
	else:
		create_brick_wall_at_with_pu(index_x, index_y, power_up_type)
		return
	
	return

func create_brick_wall_at_with_pu(index_x: int, index_y: int, power_up_type: Global.PowerUpType):
	var brick_wall = BRICK_WALL.instantiate()
	var brick_wall_position = Vector2(index_x * TILE_SIZE + TILE_SIZE / 2, index_y * TILE_SIZE + TILE_SIZE / 2)
	brick_wall.position = brick_wall_position
	match power_up_type:
		Global.PowerUpType.BOMB_UP:
			brick_wall.power_up_res = BOMB_UP
		Global.PowerUpType.FIRE_UP:
			brick_wall.power_up_res = FIRE_UP
		Global.PowerUpType.SPEED_UP:
			brick_wall.power_up_res = SPEED_UP
	
	add_child(brick_wall)
	
	Global.matrix[index_x][index_y] = 1
