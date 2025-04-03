extends Area2D

@onready var enemy = %enemy




func _on_body_entered(body):
	enemy.play("attack_slimeG")
