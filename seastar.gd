extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var noise = OpenSimplexNoise.new()
var time = 0 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	time += delta
	position.y += sin(time*3) * 0.02
	rotation = noise.get_noise_2d(time, time) * 0.2

	#$Circle.scale.x += cos(time) * 0.0001
	#$Circle.scale.y +=  cos(time) * 0.0001
	# loop over all children using range
	for i in range($arms.get_child_count()):
		# get the child
		var child = $arms.get_child(i)
		child.rotation += sin(time + i*10) * 0.001
		
		# move up and down using sin along forward direction
		var dir = child.global_position - global_position
		var offset = dir.length() + sin(time*3 + i*10) * 0.01
		child.global_position = global_position + dir.normalized() * offset 
		child.scale.y += sin(time+i *30)*0.0001
	

		

