extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var txt = $textholder.get_node("txt")

# Called when the node enters the scene tree for the first time.
func _ready():
	# connect onbodyentered signal to the function on_body_entered
	connect("body_entered", self, "on_body_entered")
	


func on_body_entered(body):
	# if the body is the player, then call the function on_player_entered
	if body.is_in_group("player"):
		$CollisionShape2D.queue_free()
		$Light.queue_free()
		$Light2.queue_free()
		G.num_pickups += 1
		txt.text = str(G.num_pickups) + " of " + str(G.total_pickups) + " pieces found"
		txt.show()
		yield(get_tree().create_timer(5), "timeout")
		txt.hide()
