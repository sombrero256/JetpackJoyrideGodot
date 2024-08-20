class_name Player extends CharacterBody2D
# Layer 1 = player layer
# layer 2 = coin / pickup layer
# layer 3 = trap layer

@export var INIT_VELOCITY: float = -100.0
@export var VELOCITY_GAIN: float = -3000
@export var MAX_UP_VELOCITY: float = -2000

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity: float = 980

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

	move_and_slide()
