extends KinematicBody2D


var velocity_x = 0
var velocity_y = 0

var speed = 500

var facing = "left"

var on_ground
var gravity = 0

var jumping

var touching_wall = false

var dashing
var dash_timer = 20

var pogoing = false
var pogo_timer = 50


var respawn_position = Vector2(0, 0)

var deaths = 0

var level = 1




# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(200, 0)


func die():
	position = respawn_position
	deaths += 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# die if;
	if position.y > 2000:
		die()
	# Timer logic
	if dash_timer > 0 and dashing:
		dash_timer -= 1
		
	if dash_timer == 0:
		dash_timer = 20
		dashing = false
		
	if pogo_timer > 0 and pogoing:
		pogo_timer -= 1
		
	if pogo_timer == 0:
		pogo_timer = 50
		pogoing = false
		
	# collision boloons
	if $"Ground collider".overlaps_body(get_parent().get_node("Platforms")):
		on_ground = true
		
	else:
		on_ground = false
		
	if $"Wall collider".overlaps_body(get_parent().get_node("Platforms")):
		touching_wall = true
		
	else:
		touching_wall = false
	
	if $"Ground collider".overlaps_body(get_parent().get_node("Checkpoint")):
		# Next level
		level += 1
		if level == 1:
			respawn_position = Vector2(0, 0)
		if level == 3:
			respawn_position = Vector2(2500, 0)
		if level == 5:
			respawn_position = Vector2(5200, -500)
		if level == 7:
			respawn_position = Vector2(8600, -500)
		if level == 9:
			respawn_position = Vector2(11200, -500)
		if level == 11:
			respawn_position = Vector2(14000, -500)
		die()
		deaths = 0
		
	print(level)
		
	if not on_ground:
		if not touching_wall:
			gravity += 20
		else:
			gravity += 3 
	else:
		if not jumping:
			gravity = 0
		if jumping:
			jumping = false
	
	if Input.is_action_pressed("left1"):
		velocity_x -= speed
		facing = "left"
	if Input.is_action_pressed("right1"):
		velocity_x += speed
		facing = "right"
	if Input.is_action_just_pressed("jump1") and (on_ground or touching_wall):
		gravity -= 800
		jumping = true
	if Input.is_action_just_pressed("dash1") and dash_timer == 20:
		dashing = true
	if Input.is_action_just_pressed("pogo1") and not pogoing:
		pogoing = true
	
		
	if dashing:
		speed = 3000
	else:
		speed = 500
		
	if $"Ground collider".overlaps_body(get_parent().get_node("Danger")):
		print (pogoing)
		if not pogoing:
			die()
		else:
			gravity -= 500
			jumping = true
	if $"Wall collider".overlaps_body(get_parent().get_node("Danger")):
		die()
		
	velocity_y = gravity
	move_and_slide(Vector2(velocity_x, velocity_y))
	
	
	velocity_x = 0
	velocity_y = 0
	
