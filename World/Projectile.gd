extends Area2D

@export var speed = 300
@export var damage = 50
@export var pierce = 2
@export var force = 1
@export var isCrit = false
func _physics_process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(damage,isCrit)
		if pierce > 0:
			pierce -= 1
		else:
			queue_free()
	else:
		queue_free()
