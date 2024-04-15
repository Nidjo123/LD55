extends AnimatableBody2D


func _physics_process(delta):
	scale.x -= delta / 3
	if scale.x < 0.05:
		get_parent().remove_child(self)
		queue_free()
