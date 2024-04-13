extends Node2D


@export var platform_summon_cooldown: float = 1.0

var can_summon_platform = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func add_platform(at_pos, summoned_by_user=false):
	var platform = $Platform.duplicate()
	platform.position = at_pos
	platform.summoned_by_user = summoned_by_user
	platform.process_mode = Node.PROCESS_MODE_INHERIT
	add_child(platform)


func _process(delta):
	if Input.is_action_pressed("ui_down") and can_summon_platform:
		add_platform($Player.position + Vector2(0, 10), true)
		can_summon_platform = false
		$PlatformSummonCooldown.start(platform_summon_cooldown)


func _on_timer_timeout():
	var at_pos = Vector2(1500, 500 + randi_range(-200, 150))
	add_platform(at_pos, false)


func _on_platform_summon_cooldown_timeout():
	can_summon_platform = true
