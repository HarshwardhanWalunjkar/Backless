extends Node2D

const SCORE_MODIFIER = 20

@onready var hoody_dude = %hoody_dude
@onready var canvas_layer = $CanvasLayer
@onready var camera_2d = %Camera2D

var slime_blue = preload("res://scenes/slime_blue.tscn")
var slime_green = preload("res://scenes/slime_green.tscn")
var piranha_plant = preload("res://scenes/piranha_plant.tscn")
var warewolf = preload("res://scenes/warewolf.tscn")
var bird_eagle = preload("res://scenes/bird_eagel.tscn")
var bird_pigeon = preload("res://scenes/bird_pigeon.tscn")
var game_scene_2 = preload("res://scenes/game_scene_2.tscn")
var obs_types_ground := [slime_blue, slime_green, piranha_plant]
var obs_types_flying := [bird_eagle, bird_pigeon]
var bird_height := [200, 390]
var obstacles: Array
var ground_height: int
var difficulty_buffer: int
var SCORE_MODIFIED: int
var randi: int
@onready var ground = %Ground
@onready var obstimer = $obstimer

var Should_Die #decides for collision
var DEATH #decides how many times her dies
var last_obs
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	DEATH = 0
	screen_size = get_viewport().size
	ground_height = ground.get_node("CollisionShape2D").position.y
	obstimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if DEATH < 3:
		Global.SCORE += hoody_dude.SPEED
		canvas_layer.get_node("Label").text = str(Global.SCORE/SCORE_MODIFIER)
		SCORE_MODIFIED = Global.SCORE/SCORE_MODIFIER
		DEATH = hoody_dude.DEATH
		canvas_layer.get_node("CountDeath").text = str(DEATH)
		if obstimer.is_stopped():
			generate_obs()
		difficulty_buffer = SCORE_MODIFIED / 1000
		
	if not obstacles.is_empty() and hoody_dude.position.x-obstacles[0].position.x>screen_size.x:
		#print("freeing:" + str(obstacles[0]))
		obstacles[0].queue_free()
		obstacles.remove_at(0)

func generate_obs():
	difficulty_buffer *= 200
	randi=randi()
	if randi%20<13:
		var obs_type = obs_types_ground[randi()%obs_types_ground.size()]
		var obs
		obs = obs_type.instantiate()
		var obs_x : int = screen_size.x + hoody_dude.position.x + randi_range(100+difficulty_buffer,800+difficulty_buffer)
		var obs_y : int = 670
		last_obs = obs
		add_obs(obs,obs_x,obs_y)
	if randi%20>=13 and randi%20<18:
		var obs_type = obs_types_flying[randi()%obs_types_flying.size()]
		var obs
		obs = obs_type.instantiate()
		var obs_x : int = screen_size.x + hoody_dude.position.x + randi_range(100+difficulty_buffer,800+difficulty_buffer)
		var obs_y : int = randi_range(530,670)
		last_obs = obs
		add_obs(obs,obs_x,obs_y)
	if randi%20 >= 18:
		var obs
		obs = warewolf.instantiate()
		var obs_x : int = screen_size.x + hoody_dude.position.x + randi_range(100+difficulty_buffer,800+difficulty_buffer)
		var obs_y : int = 600
		last_obs = obs
		add_obs(obs,obs_x,obs_y)
func add_obs(obs, x, y):
	add_child(obs)
	obs.position = Vector2(x, y)
	obstacles.append(obs)
	obstimer.wait_time = randi_range(1, 3)
	obstimer.start()

