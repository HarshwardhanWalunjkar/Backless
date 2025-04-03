extends Label

@onready var backless = $"."

@onready var state_1 = $state1
@onready var state_2 = $state2
@onready var state_3 = $state3
@onready var state_4 = $state4
@onready var state_5 = $state5


# Called when the node enters the scene tree for the first time.
func _ready():
	state_1.visible=true
	state_2.visible=false
	state_3.visible=false
	state_4.visible=false
	state_5.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if int(backless.text)==3:
		state_2.visible=true
	if int(backless.text)==5:
		state_3.visible=true
	if int(backless.text)==8:
		state_4.visible=true
	if int(backless.text)==10:
		state_5.visible=true

