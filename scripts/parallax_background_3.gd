extends ParallaxBackground
@onready var hoody_dude_3 = $"../../hoody_dude_3"
@onready var camera_2d = %Camera2D
@onready var ground = %Ground
var screen_size : Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if  ground.position.x - hoody_dude_3.position.x > 0.02 * screen_size.x:
		ground.position.x -= screen_size.x
