class_name LevelManager
extends Node2D


@export var level: Level
@export var player: Node2D


func _ready() -> void:
	var offsets: Array[Vector2] = [
		Vector2(level.width, 0.0), #RIGHT
		Vector2(-level.width, 0.0), #LEFT
		Vector2(0.0, level.height), #DOWN
		Vector2(0.0, -level.height), #UP
		Vector2(level.width, -level.height), #UP-RIGHT
		Vector2(-level.width, -level.height), #UP-LEFT
		Vector2(level.width, level.height), #DOWN-RIGHT
		Vector2(-level.width, level.height), #DOWN-LEFT
	]
	
	for offset: Vector2 in offsets:
		var level_instance: Node2D = level.duplicate()
		add_child(level_instance)
		level_instance.position += offset


func _physics_process(_delta: float) -> void:
	if player.global_position.x > level.width:
		player.global_position.x -= level.width
	elif player.global_position.x < 0:
		player.global_position.x += level.width
	
	if player.global_position.y > level.height:
		player.global_position.y -= level.height
	elif player.global_position.y < 0:
		player.global_position.y += level.height
