extends Node2D

var SPEED_PIGEON
@onready var enemy = $enemy


func _ready():
	SPEED_PIGEON = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enemy.play("fly_pigeon")
	if enemy.flip_h == true:
		position.x-=SPEED_PIGEON
	else:
		position.x+=SPEED_PIGEON
