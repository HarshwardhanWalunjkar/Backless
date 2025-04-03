extends CharacterBody2D
@onready var anti = $"."
# Called when the node enters the scene tree for the first time.
func _ready():
	anti.position.x = Global.store_x + 200
	anti.position.y = Global.store_y
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
