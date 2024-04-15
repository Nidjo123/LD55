extends Node2D


@export var platform_summon_cooldown: float = 1.0
@export var next_level: PackedScene
@export var music_stream: AudioStream

var can_summon_platform = true


func _ready():
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


func _process(delta):
	var active_player = $Cat
	if Input.is_action_pressed("summon") and can_summon_platform and active_player.can_summon_platform:
		var capsule_half_height = active_player.get_node("CollisionShape2D").shape.height
		var platform_offset = Vector2(0, $Platform/CollisionShape2D.shape.size.y + capsule_half_height * 2)
		add_platform(active_player.position + platform_offset, true)
		can_summon_platform = false
		$PlatformSummonCooldown.start(platform_summon_cooldown)


func _on_platform_summon_cooldown_timeout():
	can_summon_platform = true


func go_to_next_level():
	if next_level:
		get_tree().change_scene_to_packed(next_level)


func _on_world_limit_exited(body):
	if $Cat == body:
		print("reloading current scene")
		get_tree().reload_current_scene()


func _on_exit_area_body_entered(body):
	if $Cat == body:
		get_tree().create_timer(1).timeout.connect(go_to_next_level)
