extends AnimatedSprite2D
@onready var invinc_bar = $"."
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not timer.is_stopped():
		invinc_bar.play("refresh")
	else:
		invinc_bar.play("full")

func refresh():
	timer.start()
