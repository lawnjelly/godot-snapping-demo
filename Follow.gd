extends Node2D

var target

func _ready():
	target = get_node("../Player")


func _physics_process(delta):

	var pos_target = target.position
	
	
	# in pixels
	var offset = pos_target - position

	var max_dist = 20.0
	offset.x = clamp(offset.x, -max_dist, max_dist)
	offset.y = clamp(offset.y, -max_dist, max_dist)

	debug_print(str(offset))
	
	position = pos_target - offset

	
func debug_print(sz):
	$Camera2D/Label.text = sz
	
