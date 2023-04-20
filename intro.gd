extends Area2D


var follow = false
var player = null


export var outro = false

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
		follow = false
		if not outro:
			player.position = get_tree().get_nodes_in_group("startpos")[0].position
		else:
			player.position = get_tree().get_nodes_in_group("endpos")[0].position
			player.reset()
			
		$intro_fish.queue_free()

		yield(get_tree().create_timer(4), "timeout")
		
		get_tree().get_nodes_in_group("fadetoblack")[0].hide()

		if not outro:
			player.begin_game()
		else:
			player.reset()

