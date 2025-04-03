extends ParallaxBackground
@onready var hoody_dude = %hoody_dude
@onready var camera_2d = %Camera2D
@onready var ground = %Ground
var screen_size : Vector2i

func _ready():
	screen_size = get_viewport().size
	
func _process(delta):
	if hoody_dude.position.x - ground.position.x > 0.98 * screen_size.x:
		ground.position.x += screen_size.x
		 

