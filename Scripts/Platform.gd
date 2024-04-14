extends AnimatableBody2D


@export var speed: float = 150
@export var vanish_time: float = 2
@export var cutoff_scale: float = 0.5


var summoned_by_user = false


func _ready():
	$CollisionShape2D/CPUParticles2D.lifetime = vanish_time
	$CollisionShape2D/CPUParticles2D.emitting = true
	if summoned_by_user:
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2(cutoff_scale, 1), vanish_time)


func _physics_process(delta):
	if scale.x <= cutoff_scale:
		get_parent().remove_child(self)
		queue_free()
	
