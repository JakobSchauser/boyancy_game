extends Node2D


var noise = OpenSimplexNoise.new()
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta

	for i in range($tail.get_child_count()):
		var child = $tail.get_child(i)
		var noise_val = noise.get_noise_1d(i*20 + time* (i*0.1 + 10.2)) 
		child.rotation = noise_val * 0.4
	
	var scale1 = sin(time*2)*0.0001# range_lerp(sin(time), -1,1, -0.01, 0.01)

	$head1.scale.x += scale1
	$head1.scale.y += scale1

	# do it for the other head
	$head2.scale.x -= scale1 * 10
	$head2.scale.y -= scale1 * 10

	# move head back and forth on x
	var scale2 = sin(time)*0.01
	$head1.position.x += scale2

	$head1.rotation = sin(time*2)*0.01


