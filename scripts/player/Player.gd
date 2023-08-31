extends CharacterBody3D


@export var speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var gravity: float = 15
@export var sensibility: float = 0.1

@onready var head: Node3D = $Head
@onready var main_camera: Camera3D = $Head/MainCamera


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	
	# Camera behaviour
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sensibility))
		head.rotate_x(deg_to_rad(-event.relative.y * sensibility))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
