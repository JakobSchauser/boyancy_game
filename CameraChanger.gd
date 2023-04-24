extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var outro = false

var newpos = Vector2(0, -65)
var newzoom = Vector2(1.5, 1.5)
var camera = null
var should_move = false

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "on_body_entered")
	if outro:
		newzoom = Vector2(20, 20)
		# newpos = Vector2(0, -100)

func _process(delta):
	if not should_move:
		return

	# linearly interpolate to new position
	var s = 0.01
	if outro:
		s = 0.1
	camera.position = camera.position.linear_interpolate(newpos, 0.02)
	camera.zoom = camera.zoom.linear_interpolate(newzoom, 0.05)
	
	# camera.position = camera.position.lerp(newpos, 0.01)
	# camera.zoom = camera.zoom.lerp(newzoom, 0.01)

	if camera.position.distance_to(newpos) < 0.1 and camera.zoom.distance_to(newzoom) < 0.1:
		should_move = false



func on_body_entered(body):
	if body.is_in_group("player"):
		camera = body.get_node("Camera2D")
		should_move = true
