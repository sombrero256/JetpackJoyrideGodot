class_name Coin extends Area2D

signal coin_collected


# Called when the node enters the scene tree for the first time.
func _ready():
	var GM = find_parent("GameManager") as GameManager
	self.connect("coin_collected", GM._on_coin_collected)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	coin_collected.emit()
	queue_free()
	pass # Replace with function body.
