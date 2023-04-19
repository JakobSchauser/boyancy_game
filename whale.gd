extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	# connect onbodyentered signal to the function on_body_entered
	connect("body_entered", self, "on_body_entered")
	#connect to timer
	$Timer.connect("timeout", self, "on_timeout")
	


func _process(delta):
	# move the enemy
	position.x += 100 * delta * direction

func on_body_entered(body):
	# if the body is the player, then call the function on_player_entered
	if body.is_in_group("player"):
		body.kill()

func on_timeout():
	direction = randi()%2*2 - 1
	position = get_tree().get_nodes_in_group("player")[0].position - Vector2(800,randi()%100-50)*direction
	$Timer.start(5)
	print("timer started")


