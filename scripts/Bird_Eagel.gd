extends Node2D

var SPEED_EAGLE
@onready var enemy = $enemy


func _ready():
	SPEED_EAGLE = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enemy.play("default")
	if enemy.flip_h == true:
		position.x-=SPEED_EAGLE
	else:
		position.x+=SPEED_EAGLE
