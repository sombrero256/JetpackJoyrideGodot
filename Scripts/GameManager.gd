class_name GameManager extends Node2D

const SPEED_GAIN_FACTOR = 0.05
const MAX_SPEED = 1600
const ROOMS_FOR_SPEED_INCREASE = 10

var Coins_Collected = 0
var Rooms_Passed = 0
var Total_Rooms_Passed = 0
var TimeTilNextCoins = 0

var UpperThirdY = 0
var MiddleThirdY = 0
var LowerThirdY = 0

var SpawnPoints = []

@onready var ScreenSize = get_viewport().get_visible_rect().size as Vector2

@export var CoinGroupList = []

@onready var Player := $PlayerCharacter as Player
@onready var RoomScene = preload("res://Compositions/room.tscn")
@onready var RootRoom := $Room as Room
# Called when the node enters the scene tree for the first time.
func _ready():
	# hardcode 40 for room collider sizes
	# hardcode 20 to start from ceiling
	UpperThirdY = 20 + ((ScreenSize.y - 40) / 3)/2
	MiddleThirdY = UpperThirdY + (ScreenSize.y - 40) / 3
	LowerThirdY = MiddleThirdY + (ScreenSize.y - 40) / 3
	
	SpawnPoints.append(UpperThirdY)
	SpawnPoints.append(MiddleThirdY)
	SpawnPoints.append(LowerThirdY)
	# spawn second starting room
	add_room_at_end()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Handle_Environment(delta)
	Handle_Difficulty()
	if TimeTilNextCoins <= 0:
		spawn_coin_group()
		TimeTilNextCoins = 5
	else: TimeTilNextCoins -= delta
	pass

func Handle_Environment(delta):
	Room_Movement(delta)
	# add coin + hazard spawning here
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
	Rooms_Passed += 1
	Total_Rooms_Passed += 1
	print(Rooms_Passed)

func _on_coin_collected():
	Coins_Collected += 1
	pass # Replace with function body.

func Room_Movement(delta):
	RootRoom.move_room_list(delta)
	if RootRoom.RoomSnap.position.x <= 0:
		add_room_at_end()
		var t = RootRoom
		RootRoom = RootRoom.NextRoom
		RootRoom.PrevRoom = null
		t.queue_free()

func Handle_Difficulty():
	if Rooms_Passed >= ROOMS_FOR_SPEED_INCREASE:
		Rooms_Passed = 0
		RootRoom.Speed += RootRoom.Speed * SPEED_GAIN_FACTOR
		if RootRoom.Speed >= MAX_SPEED:
			RootRoom.Speed = MAX_SPEED

func _on_group_collected():
	print("Group collected")

func spawn_coin_group():
	var rand = randi() % 3
	var TempCG = CoinGroupList[0].instantiate() as CoinGroup
	TempCG.position = Vector2(ScreenSize.x, SpawnPoints[rand])
	TempCG.speed = RootRoom.Speed
	add_child(TempCG)
