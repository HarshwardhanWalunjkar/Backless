extends CharacterBody2D

const START_SPEED = -7
const MAX_SPEED = -30
const SPEED_INCREMENT = 0.5
const JUMP_VELOCITY = -500.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# backless Variable to evade death during fade anim
var backless = 0
var SPEED : float 
var SPEED_SLOW_CAM : float
var store_x
var store_y
var store_cam_x
var store_cam_y
var store_ground_x
var store_ground_y
var flag = 1
var flag1 = 1

@onready var hoody_dude_3 = $"."
@onready var camera_2d = %Camera2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var run_col = $RunCol
@onready var duck_col = $DuckCol
@onready var float_col = $FloatCol
@onready var timer = $Timer
@onready var timer_2 = $Timer2
@onready var timer_3 = $Timer3
@onready var timer_4 = $Timer4
@onready var timer_5 = $Timer5
@onready var timer_increment = $Timer_Increment
@onready var ground = %Ground

@onready var jump = $jump
@onready var landing = $Landing
@onready var duck = $duck
@onready var hit = $hit
@onready var invincible = $invincible

@onready var invinc_bar = %invinc_bar


# Called when the node enters the scene tree for the first time.
func _ready():
	hoody_dude_3.position.x = Global.store_x
	hoody_dude_3.position.y = Global.store_y
	camera_2d.position.x = Global.store_cam_x
	camera_2d.position.y = Global.store_cam_y
	hoody_dude_3.get_node("AnimatedSprite2D").flip_h = true
	SPEED = START_SPEED
	timer_increment.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flag1 == 1:
		if timer_increment.is_stopped():
			if SPEED < MAX_SPEED:
				SPEED = MAX_SPEED
			else:
				SPEED = SPEED - SPEED_INCREMENT
				print(SPEED)
				timer_increment.start()
				
		camera_2d.position.x += SPEED
		hoody_dude_3.position.x += SPEED
		if velocity.y==0:
			if Input.is_action_just_pressed("jump"):
				float_col.disabled = true
				velocity.y = JUMP_VELOCITY
				animated_sprite_2d.play("jump")
				jump.play()
				timer_5.start()
			if Input.is_action_just_pressed("duck"):
				run_col.disabled = true
				animated_sprite_2d.play("duck")
				duck.play()
				timer.start()
			if Input.is_action_just_pressed("fade"):
				if timer_3.is_stopped():
					run_col.disabled = true
					duck_col.disabled = true
					animated_sprite_2d.play("fade")
					invincible.play()
					timer_2.start()
					timer_3.start()
					await get_tree().create_timer(1).timeout
					invinc_bar.refresh()
				else:
					print("REFRESHING")
			if Input.is_action_just_pressed("attack"):
				animated_sprite_2d.play("attack")
				timer_4.start()
				
			if timer.is_stopped() and timer_2.is_stopped() and timer_4.is_stopped() and timer_5.is_stopped() :
				run_col.disabled = false
				duck_col.disabled = false
				float_col.disabled = false
				animated_sprite_2d.play("run")
			if backless >= 10:
				flag1 = 0 
		else:
			if timer_5.is_stopped():
				float_col.disabled = false
				landing.play()
			velocity.y += gravity * delta
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		move_and_slide()
	else:
		run_col.disabled = false
		duck_col.disabled = false
		float_col.disabled = false
		SPEED_SLOW_CAM = SPEED
		if flag==1:
			animated_sprite_2d.play("idle")
			flag = 0
		if velocity.y==0:
			hoody_dude_3.position.x += SPEED
			camera_2d.position.x += SPEED_SLOW_CAM
			SPEED*=0.99
			SPEED_SLOW_CAM*=0.98
		if int(SPEED) == 0:
			print(hoody_dude_3.position.x)
			print(camera_2d.position.x)
			Global.relative=567-(camera_2d.position.x-hoody_dude_3.position.x)
			Global.goto_scene("res://scenes/game.tscn",store_x,store_y,store_cam_x,store_cam_y,0,0,store_ground_x,store_ground_y)
			#print(store_x,store_y)
func add_backless():
	backless += 1
	SPEED*=1.05
	#print(backless)

func slow_down():
	#print("slowing down")
	SPEED/=1.1
