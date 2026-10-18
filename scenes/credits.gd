class_name Credits
extends Control

@export var container: HBoxContainer
@export var level: Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level.update_credits.connect(set_opacity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_opacity(alpha: float) -> void:
	container.modulate.a = alpha
