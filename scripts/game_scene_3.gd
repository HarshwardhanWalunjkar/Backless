extends Node2D

const SCORE_MODIFIER = 20
var SCORE_MODIFIED:int
var difficulty_buffer: int

@onready var hoody_dude_3 = $hoody_dude_3
@onready var camera_2d = $Camera2D
@onready var anti_3 = $anti_3
@onready var ground = %Ground
@onready var genobs = $genobs
@onready var canvas_layer = $CanvasLayer

var backless_orbs
var backless_temp
var backless = preload("res://scenes/back_less.tscn")
var regret = preload("res://scenes/regret.tscn")
var pos_x
var pos_y
var orb
var flag=1
var randi
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Scene Changed!")
	ground.position.x = Global.store_ground_x 
	ground.position.y = Global.store_ground_y
	genobs.start()
	backless_temp = 0
	screen_size = get_viewport().size
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if abs(hoody_dude_3.position.x-anti_3.position.x)<50:
		Global.goto_scene("res://scenes/quit_screen.tscn",33,661,600,29,0,0,0,-30)
	if hoody_dude_3.backless==10 and flag==1:
		print("Caught")
		anti_3.die()
		flag=0
	if backless_temp<10:
		Global.SCORE += hoody_dude_3.SPEED
		canvas_layer.get_node("score").text = str(Global.SCORE/SCORE_MODIFIER)
		SCORE_MODIFIED = Global.SCORE/SCORE_MODIFIER
		backless_orbs = hoody_dude_3.backless
		canvas_layer.get_node("backless").text = str(backless_orbs)
		difficulty_buffer = SCORE_MODIFIED / 1000
		
		backless_temp = hoody_dude_3.backless
		
	if genobs.is_stopped():
		randi = randi_range(1,3)
		pos_x = hoody_dude_3.position.x
		pos_y = Global.store_y
		if randi <= 2:
			orb = backless.instantiate()
			gen_obs(orb,pos_x,pos_y)
		else:
			orb = regret.instantiate()
			gen_obs(orb,pos_x,pos_y)
func gen_obs(orb,x,y):
	var off_set 
	add_child(orb)
	if randi_range(1,2) == 1:
		off_set = randi_range(0,50)
	else:
		off_set = randi_range(100,150)
	orb.position.x = x - (screen_size.x/2)
	orb.position.y = y - off_set
	genobs.start()
	
