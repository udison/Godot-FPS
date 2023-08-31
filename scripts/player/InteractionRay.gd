extends RayCast3D


func _process(delta):
	if is_colliding():
		var object = get_collider().get_owner()
		
		if Input.is_action_just_pressed("use") && object.has_method("interact"):
			object.interact()
