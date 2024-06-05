extends Node3D


# Exported sensitivity variable to adjust in the editor
@export var sensitivity: float = 0.1


# internal variables for tracking mouse movement
var rotation_x: float = 0.0
var rotation_y: float = 0.0

var mouse_visible: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Check if the Escape key is pressed
	if Input.is_action_just_pressed("right_click"):  # "ui_cancel" is mapped to the Escape key by default
		mouse_visible = not mouse_visible
		if mouse_visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	# check if the event is a mouse motion event
	if event is InputEventMouseMotion:
		# Update rotation values based on mouse movement and sensitivity
		# Clamp the vertical rotation to avoid flipping the camera
		rotation_degrees.x -= event.relative.y * sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)
		
		rotation_degrees.y -= event.relative.x * sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)
		
		# Apply the rotations to the camera
		var rotation_basis = Basis()
		rotation_basis = rotation_basis.rotated(Vector3(1, 0, 0), deg_to_rad(rotation_x))
		rotation_basis = rotation_basis.rotated(Vector3(0, 1, 0), deg_to_rad(rotation_y))
		transform.basis = rotation_basis
		
		
		
