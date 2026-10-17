class_name Gem
extends Area2D

@export var id: StringName
@export var level_manager: LevelManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerMovement:
		body.gems += 1
		print("Gem obtained")
		level_manager.free_gem(self)
	pass # Replace with function body.
