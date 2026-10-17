class_name Door
extends Area2D


signal player_interacted


var is_opened: bool = false


@onready var sprite_2d: Sprite2D = %Sprite2D


func open_door() -> void:
	is_opened = true
	sprite_2d.region_rect.position.x += 55


func interact() -> void:
	player_interacted.emit()
