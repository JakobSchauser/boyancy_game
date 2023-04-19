extends KinematicBody2D


var off_color = Color(0.1,0.1,0.1)
#onready var green = $green.modulate
#onready var red = $red.modulate

var has_boyancy = true

var time = 0
var rot_offset = 0
var noise = OpenSimplexNoise.new()

var leg_timer = 0

var vel = Vector2(0,0)
var rising = false

var bonfire = null

var blink_timers = [0,0,0]
var blink_frequencies = [0.3, 0.199, 1]
var on_time = [0.21, 0.2, 0.1] # a percent indication how long the light should be on.
onready var lights = [$eye/green, $eye/red, $light/top]

func blink(delta):
	for i in range(len(blink_timers)):
		blink_timers[i] += delta
		if blink_timers[i] / blink_frequencies[i] > on_time[i]:
			lights[i].visible = false
		else:
			lights[i].visible = true
		
		if blink_timers[i] > blink_frequencies[i]:
			blink_timers[i] = 0


func _ready():
	bonfire = position

func _physics_process(delta):
	leg_timer += delta
	blink(delta)
	time += delta
	
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
	
	if Input.is_action_just_pressed("ui_down") and has_boyancy:
		if vel.y < 0:
			vel.y = 0
			

	if not has_boyancy and vel.y >= 0:
		vel.y += 1

	if Input.is_action_pressed("ui_down") and has_boyancy:
		if not vel.y < 0:
			vel.y += 1
	
	$Particles2D.emitting = (abs(vel.length()) > 0.4) # Input.is_action_pressed("ui_down")
	$thrust.emitting = (abs(vel.length()) > 2) # Input.is_action_pressed("ui_down")

	$bubbles.stream_paused = (abs(vel.x) < 0.4)
	
	$release.emitting = Input.is_action_pressed("ui_down") and has_boyancy
	$air_release.stream_paused = !(Input.is_action_pressed("ui_down") and has_boyancy)

	# if(vel.x < 0):
	# 	$Sprite.scale.x = lerp($Sprite.scale.x, -1, 0.05*abs(vel.x)/20)
	# elif(vel.x > 0):
	# 	$Sprite.scale.x = lerp($Sprite.scale.x, 1, 0.05*abs(vel.x)/20)



	vel.x = clamp(vel.x, -20, 20)
	vel.y = clamp(vel.y, -20, 20)

	var move = move_and_slide(vel*10, Vector2(0,-1))

	# on collision


	if get_slide_count() > 0 and is_on_ceiling():
		if vel.y < 0:
			vel.y = 0
	
	# rotate based on vel.x
	rotation = vel.x * 0.02 + rot_offset
	var desired_rot_offset = 0
	if abs(vel.x) < 2:
		desired_rot_offset = sin(time) * 0.01
	else:
		time = 0
		
	rot_offset = lerp(rot_offset, desired_rot_offset, 0.1)

	$light.rotation = vel.x * 0.05
	$eye.position.x = clamp(vel.x*0.1, -1, 1) * 7
	# $eye.scale.y = range_lerp(sin(blink_timers[0]), -1, 1, 0.1, 0.12) 
	for i in range($legs.get_child_count()):
		var leg = $legs.get_child(i)
		leg.rotation = sin(leg_timer*50+i)*0.2 * min(abs(vel.x)*0.5, 2)
	



func reset():
	vel = Vector2(0,0)
	# $Particles2D.emitting = false
	$bubbles.stream_paused = true
	$air_release.stream_paused = true
	

	
func kill():
	reset()
	position = bonfire


func begin_game():
	reset()
	has_boyancy = false
