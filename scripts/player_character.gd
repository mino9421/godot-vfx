extends CharacterBody3D

const SPEED = 10.0
const JUMP_VELOCITY = 4.5



@export var sensitivity: float = 100
@export var camera = Camera3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_visible: bool = false
var rotation_x: float = 0.0
var rotation_y: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(_delta):
	# Check if the Escape key is pressed
	if Input.is_action_just_pressed("right_click"):  # "ui_cancel" is mapped to the Escape key by default
		mouse_visible = not mouse_visible
		if mouse_visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()
	
	# make camera controller match the position of the player
	$Camera_Controller.position = lerp($Camera_Controller.position, position, 0.15)

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / sensitivity
		
		$Camera_Controller/Camera_Target.rotation.x -= event.relative.y / sensitivity
		$Camera_Controller/Camera_Target.rotation.x = clamp($Camera_Controller/Camera_Target.rotation.x, deg_to_rad(-45), deg_to_rad(90))
		
		

#func _unhandled_input(event):
	## check if the event is a mouse motion event
	#if event is InputEventMouseMotion:
		## Update rotation values based on mouse movement and sensitivity
		## Clamp the vertical rotation to avoid flipping the camera
		#rotation_degrees.x -= event.relative.y * sensitivity
		#rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)
		#
		#rotation_degrees.y -= event.relative.x * sensitivity
		#rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)
		#
		## Apply the rotations to the camera
		#var rotation_basis = Basis()
		#rotation_basis = rotation_basis.rotated(Vector3(1, 0, 0), deg_to_rad(rotation_x))
		#rotation_basis = rotation_basis.rotated(Vector3(0, 1, 0), deg_to_rad(rotation_y))
		#transform.basis = rotation_basis
		#
