class_name Door
extends Area2D


signal player_interacted


var is_opened: bool = false


func open_door() -> void:
	is_opened = true


func interact() -> void:
	player_interacted.emit()
