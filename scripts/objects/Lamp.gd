extends Node3D


@onready var light = $Light


func set_state(state: bool):
	if state:
		light.show()
	else:
		light.hide()
