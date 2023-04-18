extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	connect("body_entered", self, "on_body_entered")
	


func on_body_entered(body):
	# if the body is the player, then call the function on_player_entered
	if body.is_in_group("player"):
		body.kill()






