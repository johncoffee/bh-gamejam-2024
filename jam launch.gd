extends Node3D

@export_range(5, 20, 0.5) var launchSpeedY: float

@onready var projectile:Node3D = $Node3D/projectile as Node3D

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		launchIt()

func launchIt():
	projectile.angular_velocity = Vector3(0, 0, 0)
	projectile.linear_velocity = Vector3(0, 0, 0)	
	projectile.position = $Node3D/CSGBox3D.position
	projectile.apply_central_impulse(Vector3(0,launchSpeedY,0))

