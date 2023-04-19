extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# connect onbodyentered signal to the function on_body_entered
	connect("body_entered", self, "on_body_entered")
	# connect onbodyexited signal to the function on_body_exited
	connect("body_exited", self, "on_body_exited")

	


func on_body_entered(body):
	# if the body is the player, then call the function on_player_entered
	if body.is_in_group("player"):
		body.can_rise = true


func on_body_exited(body):
	# if the body is the player, then call the function on_player_entered
	if body.is_in_group("player"):
		body.can_rise = false




