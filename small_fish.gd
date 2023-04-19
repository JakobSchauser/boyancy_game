extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var newpos = Vector2(0,0)

var timer = 0

var player = null
var xscale = 1
func _ready():
	newpos = position + Vector2(rand_range(-1,1), rand_range(-1,1))*500
	$small_fish.scale.x /= rand_range(1, 3)
	$small_fish.scale.y /= rand_range(1, 3)
	xscale = $small_fish.scale.x

	player = get_tree().get_nodes_in_group("player")[0]

	# connect to on body entered
	connect("body_entered", self, "_on_body_entered")



func _process(delta):
	if timer > 0:
		position = position + Vector2(sin(timer)*rand_range(-1,1),sin(timer))
		timer -= delta
		return

	position = position.linear_interpolate(newpos, 0.03)

	if position.x > newpos.x:
		$small_fish.scale.x = -xscale
	else:
		$small_fish.scale.x = xscale

	# scale.x = sign(position.x - newpos.x) * xscale
	# rotation = atan2(position.y - newpos.y, position.x - newpos.x)
	
	if position.distance_to(newpos) < 4:
		timer = rand_range(0.5, 3)
		var playerpos = player.position

		if (position.distance_to(playerpos) > 2000):
			newpos = playerpos + Vector2(rand_range(-1,1), rand_range(-1,1))*500
		else:
			newpos = position + Vector2(rand_range(-1,1), rand_range(-1/500,1/500))*500


func _on_body_entered(body):
	# if the body is the player, then call the function on_player_entered
	if body.is_in_group("player"):
		var changex = sign(body.position.x - position.x)*500
		var change = Vector2(changex, rand_range(-1,1)*3)
		newpos = position - change 
		timer = 0
