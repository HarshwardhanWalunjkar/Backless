extends Area2D
var DIE
func _ready():
	DIE = 0

func _on_body_entered(body):
	print("YOU DIED")
	body.add_death()
	
