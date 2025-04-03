extends CharacterBody2D

const START_SPEED = 10
const MAX_SPEED = 30
const SPEED_INCREMENT = 1
const JUMP_VELOCITY = -500.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# DEATH Variable to evade death during fade anim
var DEATH = 0
var SPEED : float 
var SPEED_SLOW_CAM = 0.98
var store_x
var store_y
var store_cam_x
var store_cam_y
var store_ground_x
var store_ground_y
var flag = 1
var flag1 = 1
@onready var animated_sprite_2d = $AnimatedSprite2D
#Collision shapes for Run and Collision
@onready var run_col = $RunCol
@onready var duck_col = $DuckCol
@onready var float_col = $FloatCol
@onready var camera_2d = %Camera2D
@onready var hoody_dude = $"."
@onready var ground = %Ground

@onready var jump = $jump
@onready var landing = $Landing
@onready var run = $run
@onready var invincible = $invincible
@onready var duck = $duck
@onready var hit = $hit


#Timer - duck / Timer2 - Fade / Timer3 - Fade refreshing / Timer 4 - attack
@onready var timer = $Timer
@onready var timer_2 = $Timer2
@onready var timer_3 = $Timer3
@onready var timer_4 = $Timer4
@onready var timer_5 = $Timer5
@onready var timer_increment = $Timer_Increment

@onready var invinc_bar = %invinc_bar

func _ready():
	hoody_dude.position.x += Global.relative
	ground.position.x+= Global.relative+33
	while camera_2d.position.x-hoody_dude.position.x<562:
		camera_2d.position.x+=0.01
	SPEED = START_SPEED
	timer_increment.start()
func _physics_process(delta):
	if flag1 == 1:
		if timer_increment.is_stopped():
			if SPEED > MAX_SPEED:
				SPEED = MAX_SPEED
			else:
				SPEED = SPEED + SPEED_INCREMENT
				#print(SPEED)
				timer_increment.start()
				
		camera_2d.position.x += SPEED
		hoody_dude.position.x += SPEED
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
			if DEATH >= 3:
				flag1 = 0 
		else:
			if timer_5.is_stopped():
				float_col.disabled = false
				landing.play()
			velocity.y += gravity * delta
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		move_and_slide()
		SPEED_SLOW_CAM = SPEED
	else:
		run_col.disabled = false
		duck_col.disabled = false
		float_col.disabled = false
		if flag==1:
			animated_sprite_2d.play("dead")
			flag = 0
		if velocity.y==0:
			hoody_dude.position.x += SPEED
			camera_2d.position.x += SPEED_SLOW_CAM
			SPEED*=0.99
			SPEED_SLOW_CAM*=0.98
		if int(SPEED) == 0:
			store_x = hoody_dude.position.x
			store_y = hoody_dude.position.y
			store_cam_x = camera_2d.position.x
			store_cam_y = camera_2d.position.y
			store_ground_x = ground.position.x
			store_ground_y = ground.position.y
			#print(store_x,store_y)
			Global.goto_scene("res://scenes/game_scene_2.tscn",store_x,store_y,store_cam_x,store_cam_y,0,0,store_ground_x,store_ground_y)
func add_death():
	hit.play()
	DEATH += 1
	#print(DEATH)
