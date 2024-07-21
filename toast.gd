extends RigidBody3D

@onready var plate:Node3D = $"../plate"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sleeping && position.distance_to(plate.position) < Vector3(2.0, 0, 0).length():
		print("landed on plate!") 
	
