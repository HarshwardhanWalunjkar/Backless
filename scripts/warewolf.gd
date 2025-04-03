extends Node2D

@onready var enemy = $enemy
var SPEED_WAREWOLF
func _ready():
	SPEED_WAREWOLF = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enemy.play("run")
	if enemy.flip_h == true:
		position.x-=SPEED_WAREWOLF
	else:
		position.x+=SPEED_WAREWOLF
