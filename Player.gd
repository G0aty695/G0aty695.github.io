extends KinematicBody


var velocity_x = 0
var velocity_y = 0
var velocity_z = 0
var gravity = 0
var speed = 6
var facing = "left"
var touching_ground
var touching_left_wall
var touching_right_wall
var touching_any_wall
var touching_roof
var jump_stage
var jumping
var wall_jumping
var wall_jump_stage = 0
var dashing = false
var dash_timer = 10
var dash_cooldown = 0
var wall_jump_direction

var level = 0
var rng = RandomNumberGenerator.new()

var shake 


func screen_shake(max_roll, intensity):
	# Shake the camera at a set intensity 
	$Camera.rotation = Vector3(0, 0, max_roll * intensity * rand_range(-1, 1))
	$Camera.translate(Vector3(intensity * intensity * rand_range(-1, 1), intensity * intensity * rand_range(-1, 1), 0))

func defualt_camera():
	# Return the camera to its normal position and state
	$Camera.translation = Vector3(0, 0, 6.197)
	$Camera.rotation_degrees = Vector3(0, 0, 0)
	
func die():
	translation = Vector3(0, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# logic for all timers
	if dash_timer < 0 and dashing:
		print(dash_timer)
		dashing = false
		dash_cooldown = 20
		defualt_camera()
	
	if dash_cooldown > 0:
		dash_cooldown -= 1
	
		
	# Sets up contact boloons
	if touching_left_wall or touching_right_wall:
		touching_any_wall = true
	else:
		touching_any_wall = false
		
	if $"Ground collider".overlaps_body(get_parent().get_node("Platform1")):
		touching_ground = true
	else:
		touching_ground = false
	if $"left wall collider".overlaps_body(get_parent().get_node("Platform1")):
		touching_left_wall = true
	else:
		touching_left_wall = false
	if $"right wall collider".overlaps_body(get_parent().get_node("Platform1")):
		touching_right_wall = true
	else:
		touching_right_wall = false
	if $"roof collider".overlaps_body(get_parent().get_node("Platform1")):
		touching_roof = true
	else:
		touching_roof = false
		
	# Add gravity
	if not touching_ground:
		if not touching_any_wall:
			gravity -= 0.4
			velocity_y = gravity
		else:
			gravity = 0 - 1
			velocity_y = gravity
	else:
		gravity = 0
		velocity_y = 0
	
	# Inputs
	if Input.is_action_pressed("left"):
		velocity_x -= speed
		facing = "left"
	if Input.is_action_pressed("right"):
		velocity_x += speed
		facing = "right"
	if Input.is_action_just_pressed("jump") and touching_ground:
		if not Input.is_key_pressed(KEY_W):
			if get_viewport().get_mouse_position().y < 200:
				jumping = true
		else:
			jumping = true
	if Input.is_action_just_pressed("jump") and not touching_ground and touching_any_wall:
		jumping = true
		
	if Input.is_action_just_pressed("dash") and dashing == false and dash_cooldown == 0:
		Input.start_joy_vibration(1, 10, 10, 2000)
		dashing = true
		dash_cooldown = 20
		dash_timer = 10
		
	
	if dashing:
		dash_timer -= 1
		screen_shake(0.01, 0.3)
		if facing == "left":
			velocity_x = 0 -speed * 3
		else:
			velocity_x = speed * 3
	if jumping:
		jump_stage += 1
		for i in range(20):
			if jump_stage == i:
				velocity_y = 60 / i
		
	if jump_stage == 20 or not Input.is_action_pressed("jump"):
		jump_stage = 0
		jumping = false

		
		
	
	
	
	move_and_slide(Vector3(velocity_x, velocity_y, velocity_z))
	velocity_x = 0
	velocity_y = 0
	velocity_z = 0
	

	




