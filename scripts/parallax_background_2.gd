extends ParallaxBackground
@onready var camera_2d = %Camera2D
@onready var hoody_dude_2 = %hoody_dude_2
@onready var ground = %Ground
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hoody_dude_2.position.x - ground.position.x > 1.5 * screen_size.x:
		ground.position.x -= screen_size.x
