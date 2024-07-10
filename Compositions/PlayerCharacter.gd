class_name Player extends CharacterBody2D


const SPEED = 300.0
const INIT_VELOCITY = -100.0
const VELOCITY_GAIN = -3000
const MAX_UP_VELOCITY = -2000

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var SpritePlayer := $AnimatedSprite2D as AnimatedSprite2D 
@onready var Collider := $CollisionShape2D as CollisionShape2D

func _process(delta):
	if is_on_floor():
		SpritePlayer.play("run")
	else:
		SpritePlayer.play('jump')

func _physics_process(delta):
	# Add the gravity.
	if not Input.is_action_pressed("ui_accept"):
		velocity.y += gravity * delta * 2.5

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = INIT_VELOCITY
	if Input.is_action_pressed("ui_accept"):	
		velocity.y += VELOCITY_GAIN * delta
	
	if velocity.y < MAX_UP_VELOCITY:
		velocity.y =  MAX_UP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
