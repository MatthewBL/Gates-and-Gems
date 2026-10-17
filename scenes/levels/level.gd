class_name Level
extends Node2D


signal gem_collected(gem: Gem)


@export var width: float:
	get:
		return width * 16
@export var height: float:
	get:
		return height * 16


var gem_count: int


@onready var gem_container: Node2D = %GemContainer


func _ready() -> void:
	for child: Node in gem_container.get_children():
		if child is Gem:
			child.on_collected.connect(update_gem_count)
			gem_count += 1


func update_gem_count(gem: Gem):
	gem_collected.emit(gem)
	gem_count -= 1
