extends CharacterBody3D

@export var cam : Node3D
@export var vis : Node3D
@onready var guh = get_node("../CamParent/Camera3D")


# Non-node


var input_dir : Vector2


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var direction
var lookReturnTimer = 0

func mouseRay():
	var mousePos = cam.get_viewport().get_mouse_position()
	var rayLeng = 1000
	var from = guh.project_ray_origin(mousePos)
	var to = from + guh.project_ray_normal(mousePos) * rayLeng
	var space = get_world_3d().direct_space_state
	var rayQuery = PhysicsRayQueryParameters3D.new()
	rayQuery.from = from
	rayQuery.to = to
	var rayResult = space.intersect_ray(rayQuery)
	return rayResult

func upd_vis(deltaTime):
	mouseRay()
	lookReturnTimer -= deltaTime
	if direction:
		lookReturnTimer = 0.5
	if (direction or lookReturnTimer > 0):
		if -velocity.x != 0 or -velocity.z != 0:
			vis.rotation.y = rotate_toward(vis.rotation.y, atan2(-velocity.x, -velocity.z), 0.1)
	elif !(mouseRay().is_empty()):
		var v = Vector2((mouseRay()["position"].x - position.x), (mouseRay()["position"].z - position.z))
		vis.rotation.y = rotate_toward(vis.rotation.y, atan2(-v.x, -v.y), 0.1)

func _physics_process(delta: float) -> void:
	update_input()
	upd_vis(delta)
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, cam.rotation.y)
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()


func update_input():
	input_dir = Input.get_vector("A", "D", "W", "S")
