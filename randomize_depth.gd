extends Node2D


func _ready():
	var depth = get_tree().get_nodes_in_group("depth")
	for d in depth:
		var c = rand_range(0.8,1)
		d.modulate.color = Color(c,c,c,0.5)