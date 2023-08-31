extends Node3D
class_name Switch


@export var state: bool = false
@export var object_linked: Node3D = null

@onready var switch_mesh: Node3D = $Mesh/Switch


func interact():
	toggle_state()


func toggle_state():
	state = !state
	switch_mesh.rotation_degrees.z = -switch_mesh.rotation_degrees.z
	
	if object_linked:
		object_linked.set_state(state)
