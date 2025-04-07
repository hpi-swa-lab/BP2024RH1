extends Area2D

class_name Bomb

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const CENTRAL_EXPLOSION = preload("res://scenes/bombs/CentralExplosion.tscn")
#@onready var raycast: Raycast = $Raycast
#@export var wall_collision: bool = false

@export var explosion_size = 1

func _ready() -> void:
	pass
	
#func _process(delta: float) -> void:
#	var collisions = raycast.check_collisions()
#	if collisions != []:
#		wall_collision = true
	
	
func _on_timer_timeout() -> void:
	animated_sprite_2d.play("last_second")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "last_second":
		var explosion = CENTRAL_EXPLOSION.instantiate()
		explosion.position = position
		explosion.explosion_size = explosion_size
		get_tree().root.add_child(explosion)
		queue_free()
