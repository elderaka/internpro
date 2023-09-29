extends Node2D


func handle_bullet_spawn(bullet, pos, direction):
	bullet.global_position = pos
	bullet.rotation = direction
	add_child(bullet)
	
