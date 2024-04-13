extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var platform = $Platform.duplicate()
	platform.position.x = 1500
	platform.position.y = 500 + randi_range(-200, 150)
	platform.process_mode = Node.PROCESS_MODE_INHERIT
	add_child(platform)
