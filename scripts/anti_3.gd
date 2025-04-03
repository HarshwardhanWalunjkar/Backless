extends CharacterBody2D

@onready var anti_3 = $"."
@onready var timer_wait = $Timer_Wait
@onready var timer_increment = $Timer_Increment


@onready var laugh = $laugh
@onready var death = $death

var SPEED = -7
var SPEED_INCREMENT = 0.5
var flag=1
# Called when the node enters the scene tree for the first time.
func _ready():
	anti_3.position.x = Global.store_anti_x
	anti_3.position.y = Global.store_anti_y
	timer_wait.start()
	await get_tree().create_timer(0.25).timeout
	laugh.play()
	timer_increment.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flag==1:
		if timer_wait.is_stopped():
			anti_3.get_node("AnimatedSprite2D").play("run")
			anti_3.position.x += SPEED
		if timer_increment.is_stopped():
			SPEED = SPEED - SPEED_INCREMENT
			timer_increment.start()
	else:
		anti_3.position.x+=SPEED
		await get_tree().create_timer(0.01).timeout
		SPEED = SPEED*0.99
func die():
	flag=0
	anti_3.get_node("AnimatedSprite2D").play("death")
	death.play()
	await get_tree().create_timer(1).timeout
	anti_3.get_node("AnimatedSprite2D").visible=false
		
	
	
