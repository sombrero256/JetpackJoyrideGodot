extends Node2D

var Current_Distance = 0
var Coins_Collected = 0
var Difficulty = 1

@onready var Player := $PlayerCharacter as Player
@onready var RoomScene = preload("res://Compositions/room.tscn")
@onready var RootRoom := $Room as Room
# Called when the node enters the scene tree for the first time.
func _ready():
	# spawn second starting room
	add_room_at_end()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Handle_Environment(delta)
	pass


func Handle_Environment(delta):
	RootRoom.move_room_list(delta)
	if RootRoom.RoomSnap.position.x <= 0:
		add_room_at_end()
		var t = RootRoom
		RootRoom = RootRoom.NextRoom
		RootRoom.PrevRoom = null
		t.queue_free()
	pass
	
func add_room_at_end():
	var n = RootRoom
	while n.NextRoom != null:
		n = n.NextRoom
	var TempRoom = RoomScene.instantiate() as Room
	TempRoom.PrevRoom = n
	n.NextRoom = TempRoom
	TempRoom.position = n.RoomSnap.position
	add_child(TempRoom)
