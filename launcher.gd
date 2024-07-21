extends Node3D

@onready var toastBread:RigidBody3D = $toast as RigidBody3D
@onready var toaster:Node3D = $toaster as Node3D
@onready var plate:Node3D = $plate as Node3D

@onready var camOrigin:Vector3 = $Camera3D.position

@export_range(0, 10, 0.1) var launchSpeedX: float
@export_range(0, 10, 0.1) var launchSpeedY: float

var won = false

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		launchToast()
		
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


func _on_toast_body_entered(body):
	$sounds/impact.play()
	
