extends AnimatableBody2D


@export var speed: float = 150


func _physics_process(delta):
	position.x -= speed * delta
	
	if position.x < -2000:
		get_parent().remove_child(self)
		queue_free()
	
