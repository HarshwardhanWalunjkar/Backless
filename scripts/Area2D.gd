extends Area2D
@onready var regret_orb = $regret_orb


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	regret_orb.play()
	body.slow_down()
