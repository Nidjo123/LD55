extends CharacterBody2D


@export var speed: float = 300.0
@export var jump_velocity: float = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1500 #ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		$AnimatedSprite2D.flip_h = direction < 0 


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
