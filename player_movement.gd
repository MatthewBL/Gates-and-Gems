class_name PlayerMovement
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_DROP_VELOCITY = 1200.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Max drop velocity
	if velocity.y > MAX_DROP_VELOCITY:
		velocity.y = MAX_DROP_VELOCITY

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Long jump.
	if Input.is_action_just_released("ui_accept") and !is_on_floor() and velocity.y < 0:
		velocity.y = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_door_body_entered(body: Node2D) -> void:
	print("Door entered")
	pass # Replace with function body.
