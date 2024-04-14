extends Sprite2D


@export var unlocks: Node
var done: bool = false


func _ready():
	pass


func _process(delta):
	pass


func _on_trigger_area_body_entered(body):
	if done:
		return
	unlocks.emit_signal("unlocked")
	done = true
