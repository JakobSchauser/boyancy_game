extends KinematicBody2D


var vel = Vector2(0,0)
var rising = false

var bonfire = null

func _ready():
	bonfire = position

func _physics_process(delta):
	
	if not vel.y < 0:
		vel *= 0.9

	if vel.y < 0:
		var vy = vel.y
		vel *= 0.9
		vel.y = vy
	
	if Input.is_action_pressed("ui_right"):
		vel.x += 1

	if Input.is_action_pressed("ui_left"):
		vel.x -= 1
	
	if Input.is_action_just_pressed("ui_down"):
		if vel.y < 0:
			vel.y = 0
			
	if Input.is_action_pressed("ui_down"):
		if not vel.y < 0:
			vel.y += 1
	
	$Particles2D.emitting = Input.is_action_pressed("ui_down")
	$bubbles.stream_paused = (abs(vel.x) < 0.4)
	$air_release.stream_paused = !Input.is_action_pressed("ui_down")



	vel.x = clamp(vel.x, -20, 20)
	vel.y = clamp(vel.y, -20, 20)

	var move = move_and_slide(vel*10, Vector2(0,-1))

	# on collision


	if get_slide_count() > 0 and is_on_ceiling():
		if vel.y < 0:
			vel.y = 0


func reset():
	vel = Vector2(0,0)
	$Particles2D.emitting = false
	$bubbles.stream_paused = true
	$air_release.stream_paused = true
	

	
func kill():
	reset()
	position = bonfire


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
