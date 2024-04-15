extends Node2D


@export var platform_summon_cooldown: float = 1.0
@export var next_level: PackedScene
@export var music_stream: AudioStream

var can_summon_platform = true


func _ready():
	assert($Cat.active != $Human.active)
	if $Cat.active:
		$Cat/Camera2D.make_current()
	elif $Human.active:
		$Human/Camera2D.make_current()
		
	_update_music()


func _update_music():
	if music_stream:
		var music_node = get_node("/root/MusicTheme")
		music_node.stream = music_stream
		music_node.play()


func add_platform(at_pos, summoned_by_user=false):
	var platform = $Platform.duplicate()
	platform.position = at_pos
	platform.summoned_by_user = summoned_by_user
	platform.process_mode = Node.PROCESS_MODE_INHERIT
	platform.visible = true
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
	if Input.is_action_pressed("summon") and can_summon_platform and active_player.can_summon_platform:
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


func go_to_next_level():
	if next_level:
		get_tree().change_scene_to_packed(next_level)


var inside_area_bodies = []


func _on_exit_area_body_entered(body):
	inside_area_bodies.append(body)
	if $Cat in inside_area_bodies and $Human in inside_area_bodies:
		get_tree().create_timer(1.0, true).connect("timeout", go_to_next_level)


func _on_exit_area_body_exited(body):
	var idx = inside_area_bodies.find(body)
	if idx >= 0:
		inside_area_bodies.remove_at(idx)
