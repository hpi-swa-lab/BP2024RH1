extends Area2D

class_name BrickWall

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const POWER_UP_SCENE = preload("res://scenes/PowerUp.tscn")
@export var power_up_res: PowerUpRes


func destroy(): 
	animated_sprite_2d.play("destroy")
	

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "destroy":
		#powerup spawnen wenn vorhanden
		if power_up_res != null:
			spawn_power_up()
		
		#da wand weg muss matrix wert für diese auf 0 gesetzt werden 
		var index_x = floor(position.x / Global.TILE_SIZE)
		var index_y = floor(position.y / Global.TILE_SIZE)
		Global.matrix[index_x][index_y] = 0
		
		queue_free()

func spawn_power_up():
	var power_up = POWER_UP_SCENE.instantiate()
	power_up.global_position = global_position
	var world = get_parent()
	world.add_child(power_up) 
	power_up.init(power_up_res)
