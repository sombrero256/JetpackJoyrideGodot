class_name CoinGroup extends Node2D

signal group_collected

var speed = 0

@onready var CoinList = get_children() as Array
# - 1 is a hacky solution so that the bounding box used in spawning doesn't get counted as a coin
@onready var NumCoins = CoinList.size() - 1
@onready var GM = find_parent("GameManager") as GameManager
# Called when the node enters the scene tree for the first time.
func _ready():
	for c in CoinList:
		c.connect("coin_collected", self._on_coin_collected)
	self.connect("group_collected", GM._on_group_collected)
	pass # Replace with function body.

func _process(delta):
	pass

func _physics_process(delta):
	position = position - Vector2(speed * delta, 0)

func _on_coin_collected():
	NumCoins -= 1
	if(NumCoins <= 0):
		group_collected.emit()
		queue_free()
	pass

