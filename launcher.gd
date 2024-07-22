extends Node3D

@onready var toastBread:RigidBody3D = $toast as RigidBody3D
@onready var toaster:Node3D = $toaster as Node3D
@onready var plate:Node3D = $plate as Node3D

@onready var camOrigin:Vector3 = $Camera3D.position

@export_range(0, 10, 0.1) var launchSpeedX: float
@export_range(0, 10, 0.1) var launchSpeedY: float

@export_range(5, 25, 0.25) var launchJamSpeedY: float

@onready var projectile:Node3D = $jam/projectile

#func _process(delta):
	#if Input.is_action_just_pressed("shoot"):
		#launchIt()

var won = false
var toastLaunched = false
var jamLaunched = false

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("resetter"):
		if get_tree():
			get_tree().reload_current_scene()
		return
		
	if Input.is_action_just_pressed("shoot"):
		if !toastLaunched:
			toastLaunched = true
			launchToast()
		elif !jamLaunched:
			jamLaunched = true
			launchIt()
		elif jamLaunched && toastLaunched:
			# reset toast
			toastBread.linear_velocity = Vector3()
			toastBread.angular_velocity = Vector3(0, 0, 0)	
			toastBread.position = toaster.position
			# reset jam
			projectile.angular_velocity = Vector3(0, 0, 0)
			projectile.linear_velocity = Vector3(0, 0, 0)	
			projectile.position = $jam.position
			
			toastLaunched = false
			jamLaunched = false
		
		# detect win
	if !won && toastBread.sleeping && toastBread.position.distance_to(plate.position) < Vector3(1.5, 0, 0).length():
		won = true
		on_win()
		
	#shake
	if won:
		$Camera3D.position = camOrigin + Vector3( randf() * 0.1, randf() * 0.1, 0 )
	
func on_win():
	($sounds/jazz as AudioStreamPlayer).stop()
	($sounds/metal as AudioStreamPlayer).play()
	$ui/RichTextLabel.visible = true
	
func launchToast():
	($"sounds/toast shoot" as AudioStreamPlayer).play()
	toastBread.linear_velocity = Vector3()
	toastBread.angular_velocity = Vector3(0, 0, -1)	
	toastBread.position = toaster.position
	toastBread.apply_central_impulse(Vector3(launchSpeedX,launchSpeedY,0))
	
	# reset jam
	projectile.angular_velocity = Vector3(0, 0, 0)
	projectile.linear_velocity = Vector3(0, 0, 0)	
	projectile.position = $jam.position

func _on_toast_body_entered(body):
	$sounds/impact.play()
	
func launchIt():
	projectile.angular_velocity = Vector3(0, 0, 0)
	projectile.linear_velocity = Vector3(0, 0, 0)	
	projectile.position = $jam.position
	projectile.apply_central_impulse(Vector3(0,launchJamSpeedY,0))
	
