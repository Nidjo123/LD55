extends Node2D


@export var platform_summon_cooldown: float = 1.0

var can_summon_platform = true


func _ready():
	assert($Cat.active != $Human.active)
	update_camera()


func add_platform(at_pos, summoned_by_user=false):
	var platform = $Platform.duplicate()
	platform.position = at_pos
	platform.summoned_by_user = summoned_by_user
	platform.process_mode = Node.PROCESS_MODE_INHERIT
	add_child(platform)


func update_camera():
	var tween = get_tree().create_tween()
	if $Human.active:
		var camera = $Human/Camera2D
		camera.global_position = $Cat.global_position
		tween.tween_property(camera, "position", Vector2.ZERO, 0.75).set_trans(Tween.TRANS_SINE)
		camera.make_current()
	else:
		var camera = $Cat/Camera2D 
		camera.global_position = $Human.global_position
		tween.tween_property(camera, "position", Vector2.ZERO, 0.75).set_trans(Tween.TRANS_ELASTIC)
		camera.make_current()


func switch_character():
	assert($Cat.active != $Human.active)
	$Cat.active = !$Cat.active
	$Human.active = !$Human.active
	update_camera()


func _process(delta):
	if Input.is_action_just_pressed("switch_character"):
		switch_character()
		return

	var active_player = $Cat if $Cat.active else $Human
	if Input.is_action_pressed("ui_down") and can_summon_platform and active_player.can_summon_platform:
		var capsule_half_height = active_player.get_node("CollisionShape2D").shape.height
		var platform_offset = Vector2(0, $Platform/CollisionShape2D.shape.size.y + capsule_half_height * 2)
		add_platform(active_player.position + platform_offset, true)
		can_summon_platform = false
		$PlatformSummonCooldown.start(platform_summon_cooldown)


func _on_timer_timeout():
	var at_pos = Vector2(1500, 500 + randi_range(-200, 150))
	add_platform(at_pos, false)


func _on_platform_summon_cooldown_timeout():
	can_summon_platform = true
