class_name Level
extends Node2D


@export var width: float
@export var height: float
@export var gem_count: int
@export var gems: Array[Gem]

func _ready() -> void:
	for gem in gems:
		gem.on_collected.connect(update_gem_count)

func update_gem_count(gem: Gem):
	gem_collected.emit(gem)
	gem_count -= 1

signal gem_collected(gem: Gem)
