extends Node3D
class_name Weapon

enum FireMode {
	SAFE = -1, SINGLE, BURST, FULL_AUTO
}

@export var bullet_scene: PackedScene = null

@export_group("Weapons Stats")
@export var damage: float = 20.0
@export var fire_rate: float = .1 # Time between shots

@export_group("Fire modes")
@export var selected_fire_mode: FireMode = FireMode.SINGLE
@export_flags('Single', 'Burst', 'Full Auto') var allowed_fire_modes: int = 1

@onready var muzzle: Node3D = $Muzzle
@onready var fire_rate_timer: Timer = $FireRateTimer

var can_shot := true


func _ready():
	fire_rate_timer.wait_time = fire_rate


func _process(delta: float):
	check_fire()


func check_fire():
	var is_fire_pressed := false
	
	if selected_fire_mode == FireMode.FULL_AUTO:
		is_fire_pressed = Input.is_action_pressed('fire')
	
	elif selected_fire_mode == FireMode.SINGLE or selected_fire_mode == FireMode.BURST:
		is_fire_pressed = Input.is_action_just_pressed('fire')
	
	if not is_fire_pressed or not can_shot:
		return
	
	fire()


func fire():
	if !bullet_scene:
		printerr("Bullet scene not provided for node " + name)
		return
	
	var bullet = bullet_scene.instantiate()
	get_tree().get_root().add_child(bullet)
	bullet.global_position = muzzle.global_position
	bullet.global_rotation = muzzle.global_rotation
	
	can_shot = false
	fire_rate_timer.start()


func _on_fire_rate_timer_timeout():
	can_shot = true
