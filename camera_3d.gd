extends Node3D

@export var player : CharacterBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#var camMoveCooldown = 0.35
#var lastCamMove = 0.0
var camSpeed = 15
var end = rotation.y
#var directionFaced = 360
#var speed = 0

func rotateCam(deltaTime):
	#if (rad_to_deg(end) > 360):
		#end = deg_to_rad((rad_to_deg(end)- 180) - 180)
	#elif (rad_to_deg(end) < -360.0):
		#end = deg_to_rad((rad_to_deg(end) + 360) + 360)
	#if (angle != 0):
		#speed = angle / camSpeed
	#if (rotation.y != end or rotation.y < (end - deg_to_rad(2.5)) and rotation.y > (end + deg_to_rad(2.5))):
		#rotate_y(deg_to_rad(speed * deltaTime))
	#if (rotation.y > (end - deg_to_rad(2.5)) and rotation.y < (end + deg_to_rad(2.5))):
		#rotation.y = end
		#print('yay')
	#print(rad_to_deg(rotation.y))
	#print(rad_to_deg(end))
	end = wrapf(end, deg_to_rad(0), deg_to_rad(360))
	rotation.y = lerp_angle(rotation.y, end, camSpeed * deltaTime)
	#directionFaced += angle
	#if (directionFaced > 360):
		#directionFaced -= 360
	#elif (directionFaced <= 0):
		#directionFaced += 360
	rotation.y = wrapf(rotation.y, deg_to_rad(0), deg_to_rad(360))
	#print(rad_to_deg(rotation.y))

func camRotate(deltaTime): 
	#if (lastCamMove >= camMoveCooldown):
	if (Input.is_action_just_pressed("F")):
		#lastCamMove = 0
		end += deg_to_rad(-60)
		rotateCam(deltaTime)
		#rotate_y(deg_to_rad(-45))
	elif (Input.is_action_just_pressed("G")):
		#rotate_y(deg_to_rad(45))
		#lastCamMove = 0
		end += deg_to_rad(60)
		rotateCam(deltaTime)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = player.position
	#lastCamMove += delta
	camRotate(delta)
	rotateCam(delta)
	pass
