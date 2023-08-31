extends StaticBody3D
class_name Bullet

@export var speed: float = 10.0

var motion: Vector3 = Vector3.ZERO

func _physics_process(delta):
	#        forward
	motion = -global_transform.basis.z * speed * delta
	var collision = move_and_collide(motion)
	
	if collision:
		queue_free()
