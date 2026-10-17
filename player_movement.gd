class_name PlayerMovement
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const QUICKSAND_JUMP_VELOCITY = -300.0
const MAX_DROP_VELOCITY = 1200.0
const MAX_QUICKSAND_VELOCITY = 100.0
const QUICKSAND_GRAVITY_MULTIPLIER = 0.2
var onQuickSand = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if onQuickSand:
			velocity += QUICKSAND_GRAVITY_MULTIPLIER * get_gravity() * delta
		else:
			velocity += get_gravity() * delta

	# Max quicksand velocity
	if onQuickSand and velocity.y > MAX_QUICKSAND_VELOCITY:
		velocity.y = MAX_QUICKSAND_VELOCITY
		
	# Max drop velocity
	if velocity.y > MAX_DROP_VELOCITY:
		velocity.y = MAX_DROP_VELOCITY

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or onQuickSand):
		if onQuickSand:
			velocity.y += QUICKSAND_JUMP_VELOCITY
		else:
			velocity.y = JUMP_VELOCITY


	# Long jump.
	if not Input.is_action_pressed("ui_accept") and !is_on_floor() and velocity.y < 0:
		velocity.y = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_quicksand_detect_body_entered(_body: Node2D) -> void:
	onQuickSand = true;


func _on_quicksand_detect_body_exited(_body: Node2D) -> void:
	onQuickSand = false;
