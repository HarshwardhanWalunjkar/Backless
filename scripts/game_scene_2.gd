extends Node2D
@onready var parallax_background_2_1 = $BG/ParallaxBackground_2_1
@onready var parallax_background_2 = $BG/ParallaxBackground_2
@onready var anti = $anti
@onready var timer_scene_1 = $Timer_Scene_1
@onready var timer_scene_hold = $Timer_Scene_hold
@onready var hoody_dude_2 = %hoody_dude_2
@onready var camera_2d = %Camera2D
@onready var ground = %Ground
@onready var encounter = $encounter

var flag_visibility = 1
var flag_scene = 1
var count = 0
var store_x
var store_y
var store_cam_x
var store_cam_y
var store_anti_x
var store_anti_y
var ground_x
var ground_y
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	timer_scene_1.start()
	ground.position.x = Global.store_ground_x
	ground.position.y = Global.store_ground_y 
	screen_size=get_viewport().size
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_scene_1.is_stopped() and flag_scene == 1:
		if flag_visibility == 1 and timer_scene_hold.is_stopped():
			parallax_background_2.visible = true
			parallax_background_2_1.visible = false
			anti.visible = true
			print("now visible")
			flag_visibility = 0
			timer_scene_hold.start()
		if timer_scene_hold.is_stopped():
			parallax_background_2_1.visible = true
			parallax_background_2.visible = false
			anti.visible = false
			#print("now invisible")
			flag_visibility = 1
			timer_scene_hold.wait_time = timer_scene_hold.wait_time + 1
			count+=1
			#print(timer_scene_hold.wait_time)
			timer_scene_hold.start()
			if count == 2:
				#print("FLAGGED")
				parallax_background_2.visible = true
				parallax_background_2_1.visible = false
				anti.visible = true
				flag_scene = 0
	if flag_scene == 0:
		if anti.position.x-camera_2d.position.x<0.2*screen_size.x:
			camera_2d.position.x-=7
		else:
			await get_tree().create_timer(0.25).timeout
			store_x = hoody_dude_2.position.x
			store_y = hoody_dude_2.position.y
			store_cam_x = camera_2d.position.x
			store_cam_y = camera_2d.position.y
			store_anti_x = anti.position.x
			store_anti_y = anti.position.y 
			hoody_dude_2.queue_free()   
			Global.goto_scene("res://scenes/game_scene_3.tscn",store_x,store_y,store_cam_x,store_cam_y,store_anti_x,store_anti_y,ground.position.x,ground.position.y)
