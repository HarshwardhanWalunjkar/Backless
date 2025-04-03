extends Node

var current_scene = null
var store_x
var store_y
var store_cam_x
var store_cam_y
var store_anti_x
var store_anti_y
var store_ground_x
var store_ground_y
var relative = 0
var SCORE:int
# Called when the node enters the scene tree for the first time.
func _ready():
	SCORE = 0
	store_x=33
	store_y=661
	store_ground_x=0
	store_ground_y=-30
	store_cam_x = 600
	store_cam_y = 29
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func goto_scene(path,x,y,cam_x,cam_y,x_anti,y_anti,x_ground,y_ground):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	store_x = x
	store_y = y
	store_cam_x = cam_x
	store_cam_y = cam_y
	store_anti_x = x_anti
	store_anti_y = y_anti
	store_ground_x = x_ground
	store_ground_y = y_ground
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
