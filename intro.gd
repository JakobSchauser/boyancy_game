extends Area2D


var follow = false
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# connect onbodyentered signal to the function on_body_entered
	connect("body_entered", self, "on_body_entered")
	


func _process(delta):
	if not follow:
		return

	$intro_fish.position = $intro_fish.position.linear_interpolate(player.position, 0.05)
	
	
func on_body_entered(body):
	# if the body is the player, then call the function on_player_entered
	if body.is_in_group("player"):
		follow = true
		player = body

		yield(get_tree().create_timer(0.8), "timeout")
		
		get_tree().get_nodes_in_group("fadetoblack")[0].show()
		player.position = get_tree().get_nodes_in_group("startpos")[0].position
		follow = false

		$intro_fish.queue_free()

		yield(get_tree().create_timer(3), "timeout")
		
		get_tree().get_nodes_in_group("fadetoblack")[0].hide()
		player.begin_game()

