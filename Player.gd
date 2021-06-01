extends Node2D

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var move = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		move.x -= 1
	if Input.is_action_pressed("ui_right"):
		move.x += 1
	if Input.is_action_pressed("ui_up"):
		move.y -= 1
	if Input.is_action_pressed("ui_down"):
		move.y += 1
		
	position += (move * 1.0)

