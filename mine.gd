extends Node2D



var time = 0
onready var initial_scale = $center.scale

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$center.rotation_degrees =  20 * randi() % 10 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$center.rotation_degrees += sin(time*3.3)*0.05
	time += delta
	var scl = sin(time) * 0.001
	$center.scale.x = initial_scale.x +scl*20 
	$center.scale.y = initial_scale.y +scl*20
	$Sprite.scale.x = 0.1 + scl
	$Sprite.scale.y = 0.1 + scl
	position.y += sin(time) * 0.05