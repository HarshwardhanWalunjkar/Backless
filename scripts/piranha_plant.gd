extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_2d = $RayCast2D
var DIE = 0
func _on_body_entered(body):
	animated_sprite_2d.play("attack")
	if ray_cast_2d.collide_with_bodies == true:
		print("COLLIDED")
		DIE = 1
		print(DIE)
