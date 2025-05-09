extends Node

class_name PowerUpSys

var player: Player

@onready var bomb_placement_sys: BombPlacementSys = $"../BombPlacementSys"
@onready var movement_animation: AnimatedSprite2D = $"../movement_animation"


@export var Speed_upgrade = 5

func _ready() -> void:
	player = get_parent()

func enable_power_up(power_up_type: Global.PowerUpType):
	match power_up_type:
		Global.PowerUpType.BOMB_UP:
			player.max_bombs_at_once += 1
		Global.PowerUpType.FIRE_UP:
			player.explosion_size += 1
		Global.PowerUpType.SPEED_UP:
			player.movement_speed += Speed_upgrade
			#movement_animation.speed_scale = 3
			
		
