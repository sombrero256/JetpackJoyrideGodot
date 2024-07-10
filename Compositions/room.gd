class_name Room extends Node2D

@onready var RoomSnap := $RoomSnap as Node2D
var NextRoom = null
var PrevRoom = null
@export var Speed = 500

func _init(PR = null, NR = null, S = Speed):
	PrevRoom = PR
	NextRoom = NR
	Speed = S
	set_process(true)
	set_physics_process(true)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

func move_room_list(delta):
	if PrevRoom != null:
		position = PrevRoom.RoomSnap.position
		Speed = PrevRoom.Speed
	else:
		translate(Vector2(-Speed * delta, 0))
		RoomSnap.translate(Vector2(-Speed * delta, 0))
	if NextRoom != null:
		NextRoom.move_room_list(delta)
		pass
