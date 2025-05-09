extends Node2D

class_name Raycast


@onready var right_hori_raycast: Array[RayCast2D] = [
	$Horizontal/Right/RightHorizontaTop,
	$Horizontal/Right/RightHorizontalBottom
	]
@onready var left_hori_raycast: Array[RayCast2D] = [
	$Horizontal/Left/LeftHorizontaTop,
	$Horizontal/Left/LeftHorizontalBottom
	]
@onready var top_verti_raycast: Array[RayCast2D] = [
	$Vertical/Top/TopVerticalLeft,
	$Vertical/Top/TopVerticalRight
	]
@onready var bottom_verti_raycast: Array[RayCast2D] = [
	$Vertical/Bottom/BottomVerticalLeft,
	$Vertical/Bottom/BottomVerticalRight
]

func check_collisions() -> Array[Vector2]:
	var collisions: Array[Vector2] = []
	
	var is_left_colliding = left_hori_raycast.reduce(is_raycast_colliding, false)
	if is_left_colliding:
		collisions.append(Vector2.LEFT)
	
	var is_right_colliding = right_hori_raycast.reduce(is_raycast_colliding, false)
	if is_right_colliding:
		collisions.append(Vector2.RIGHT)
	
	var is_top_colliding = top_verti_raycast.reduce(is_raycast_colliding, false)
	if is_top_colliding:
		collisions.append(Vector2.UP)
	
	var is_bottom_colliding = bottom_verti_raycast.reduce(is_raycast_colliding, false)
	if is_bottom_colliding: 
		collisions.append(Vector2.DOWN)
	
	
	return collisions



func is_raycast_colliding(acc: bool, next: RayCast2D):
	return next.is_colliding() || acc
