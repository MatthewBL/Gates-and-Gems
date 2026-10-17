class_name Level
extends Node2D


@export var width: float:
	get:
		return width * 16
@export var height: float:
	get:
		return height * 16
@export var gem_count: int
@export var gems: Array[Gem]


func _ready() -> void:
	for gem in gems:
		gem.on_collected.connect(update_gem_count)

func update_gem_count(gem: Gem):
	gem_collected.emit(gem)
	gem_count -= 1

signal gem_collected(gem: Gem)
