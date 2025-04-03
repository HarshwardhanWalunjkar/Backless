extends Area2D
var backless
@onready var animated_sprite_2d = %AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var backless_orb = $backless_orb

func _ready():
	backless = 0

func _on_body_entered(body):
	print("backless orb captured")
	backless_orb.play()
	animated_sprite_2d.play("Picked")
	body.add_backless()
