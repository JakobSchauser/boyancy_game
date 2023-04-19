extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = false
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
	position.x += 50 * delta * direction
	position.y = lerp(position.y, player.position.y, 0.1 * delta)



func on_body_entered(body):
	# if the body is the player, then call the function on_player_entered
	if body.is_in_group("player"):
		body.kill()

func on_timeout():
	if not active:
		return

	var v = get_viewport_rect()
	var player_pos = player.position
	var diff = player_pos.x - position.x
	if abs(diff) < 2*v.x:
		$Timer.start(1)
		return
	
	if rand_range(0, 1) < 0.5:
		$Timer.start(1)
		return
	
	direction = randi()%2*2 - 1
	position = player_pos
	position.y += rand_range(-v.size.y/2, v.size.y/2) * 0.4
	if direction == 1:
		position.x = v.position.x - v.size.x * 0.8
	else:
		position.x = v.position.x + v.size.x * 0.8
		
	$Timer.start(5)


