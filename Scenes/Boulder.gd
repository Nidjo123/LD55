extends StaticBody2D


signal unlocked


func _delete():
	get_parent().remove_child(self)
	queue_free()


func _on_unlocked():
	$CPUParticles2D.emitting = true
	get_tree().create_timer(2).timeout.connect(_delete)
