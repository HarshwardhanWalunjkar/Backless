extends Label
@onready var _1 = $"1"
@onready var _2 = $"2"
@onready var _3 = $"3"
@onready var count_death = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	_3.visible=true
	_2.visible=true
	_1.visible=true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if int(count_death.text)==1:
		_3.visible=false
	if int(count_death.text)==2:
		_2.visible=false
	if int(count_death.text)==3:
		count_death.text=""
		_1.visible=false
