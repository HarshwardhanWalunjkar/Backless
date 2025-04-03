extends CharacterBody2D
@onready var hoody_dude_2 = $"."
@onready var camera_2d = %Camera2D
@onready var timer_get_up = $Timer_GetUp
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var encounter = $encounter

var flag_get_up = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	camera_2d.position_smoothing_enabled = false
	hoody_dude_2.position.x = Global.store_x
	hoody_dude_2.position.y = Global.store_y
	camera_2d.position.x = Global.store_cam_x
	camera_2d.position.y = Global.store_cam_y
	print(hoody_dude_2.position.x,hoody_dude_2.position.y)
	timer_get_up.start()
	await get_tree().create_timer(1.9).timeout
	encounter.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_get_up.is_stopped() and flag_get_up == 1:
		animated_sprite_2d.play("get_up")
		flag_get_up = 0
		
	

	
