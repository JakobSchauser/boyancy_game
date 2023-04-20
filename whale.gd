extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = true
var direction = 1

var player = null
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	# connect onbodyentered signal to the function on_body_entered
	connect("body_entered", self, "on_body_entered")
	#connect to timer
	$Timer.connect("timeout", self, "on_timeout")
	


func _process(delta):
	# move the enemy
	position.x += 50*2 * delta * direction
	position.y = lerp(position.y, player.position.y, 0.1 * delta)



func on_body_entered(body):
	# if the body is the player, then call the function on_player_entered
	if body.is_in_group("player"):
		body.kill()

func on_timeout():
	if not active:
		return
	
	print("timeout")
	var v = get_viewport_rect()
	var player_pos = player.position
	var diff = (player_pos - position).length()
	if abs(diff) < v.size.x*0.6:
		$Timer.start(1)
		return
	
	print("spawn")
	direction = randi()%2*2 - 1
	position = player_pos
	# position.y += rand_range(-v.size.y/2, v.size.y/2) * 0.4
	position.y = player_pos.y
	if direction == 1:
		position.x = player_pos.x - v.size.x*0.5
		rotation = 0 
	else:
		position.x = player_pos.x + v.size.x*0.5
		rotation = PI
		
	$Timer.start(5)


