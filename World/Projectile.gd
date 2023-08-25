extends Area2D

@export var speed = 300

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body):
	queue_free()
