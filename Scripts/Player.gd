extends CharacterBody2D


@export var speed: float = 400.0
@export var jump_velocity: float = -600.0

@export var active: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var start_position


func _ready():
	start_position = position


func _process(delta):
	var direction = Input.get_axis("left", "right")
	if direction and active:
		$AnimatedSprite2D.flip_h = direction < 0


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if active and Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction = Input.get_axis("left", "right")
	if direction and active:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	var animation_name = "default"
	if velocity.abs():
		animation_name = "walk"

	if $AnimatedSprite2D.animation != animation_name:
		$AnimatedSprite2D.play(animation_name)

	move_and_slide()


func _on_area_2d_2_body_entered(body):
	position = start_position
