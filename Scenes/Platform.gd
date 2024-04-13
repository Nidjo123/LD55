extends AnimatableBody2D


@export var speed: float = 150
@export var vanish_time: float = 1


var summoned_by_user = false


func _physics_process(delta):
	position.x -= speed * delta
	
	if summoned_by_user:
		scale.x = max(0, scale.x - delta * 1 / vanish_time)
	
	if position.x < -2000 or scale.x <= 0.01:
		get_parent().remove_child(self)
		queue_free()
	
