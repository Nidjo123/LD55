extends AnimatableBody2D

@export var speed = -400


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	position.x += delta * speed
