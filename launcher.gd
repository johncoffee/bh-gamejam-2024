extends Node3D

@onready var toastBread:RigidBody3D = $toast as RigidBody3D
@onready var toaster:Node3D = $toaster as Node3D
@onready var plate:Node3D = $plate as Node3D

@export_range(0, 10, 0.1) var launchSpeedX: float
@export_range(0, 10, 0.1) var launchSpeedY: float

var won = false

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		launchToast()
		
	# detect win
	if !won && toastBread.sleeping && toastBread.position.distance_to(plate.position) < Vector3(1.5, 0, 0).length():
		won = true
		on_win()

func on_win():
	print("Won!")

func launchToast():
	toastBread.linear_velocity = Vector3()
	toastBread.angular_velocity = Vector3()	
	toastBread.position = toaster.position
	toastBread.apply_central_impulse(Vector3(launchSpeedX,launchSpeedY,0))
