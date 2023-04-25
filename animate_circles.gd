extends Node2D


var time = 0
var noise = OpenSimplexNoise.new()

func _process(delta):
	position.y += sin(time*3) * 0.2
	time += delta
	rotation = time
	scale = Vector2(1, 1) + Vector2(1, 1) * sin(time*2) * 0.05
	for i in range(get_child_count()):
		var n = noise.get_noise_2d(time + i, 0)
		get_child(i).rotation = n * 100