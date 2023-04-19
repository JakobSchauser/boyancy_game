extends Node


var num_pickups = 0
var total_pickups = 10


func _ready():
	var depth = get_tree().get_nodes_in_group("depth")
	
	for d in depth:
		var c = rand_range(0.5,1)
		d.modulate = Color(c,c,c,1)
