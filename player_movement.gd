class_name PlayerMovement
extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const QUICKSAND_MOVEMENT_VELOCITY_MULTIPLIER = 0.5
const MAX_DROP_VELOCITY = 1200.0
const MAX_QUICKSAND_VELOCITY = 100.0
const QUICKSAND_GRAVITY_MULTIPLIER = 0.2
var onQuickSand = false


var interaction_node: Area2D


@onready var interaction_detect: Area2D = %InteractionDetect

@export var how_to_press_e: CanvasLayer


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"interact"):
		if interaction_node != null and interaction_node.has_method(&"interact"):
			interaction_node.interact()


func _ready() -> void:
	interaction_detect.area_entered.connect(on_interaction_entered)
	interaction_detect.area_exited.connect(on_interaction_exited)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Max quicksand velocity
	if onQuickSand and velocity.y > MAX_QUICKSAND_VELOCITY:
		velocity.y = MAX_QUICKSAND_VELOCITY
		
	# Max drop velocity
	if velocity.y > MAX_DROP_VELOCITY:
		velocity.y = MAX_DROP_VELOCITY

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or onQuickSand):
		velocity.y += JUMP_VELOCITY


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
	if (onQuickSand):
		velocity*=QUICKSAND_MOVEMENT_VELOCITY_MULTIPLIER

	move_and_slide()


func _on_quicksand_detect_body_entered(_body: Node2D) -> void:
	onQuickSand = true;


func _on_quicksand_detect_body_exited(_body: Node2D) -> void:
	velocity.y += JUMP_VELOCITY
	onQuickSand = false;


func on_interaction_entered(area: Area2D) -> void:
	how_to_press_e.show()
	interaction_node = area


func on_interaction_exited(area: Area2D) -> void:
	how_to_press_e.hide()
	if interaction_node == area:
		interaction_node = null
