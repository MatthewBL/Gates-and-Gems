class_name Level
extends Node2D


signal gem_collected(gem: Gem)
signal next_level


@export var width: float:
	get:
		return width * 16
@export var height: float:
	get:
		return height * 16


var gem_count: int


@onready var gem_container: Node2D = %GemContainer
@onready var door: Door = %Door
@onready var player_spawnpoint: Marker2D = %PlayerSpawnpoint


func _ready() -> void:
	door.player_interacted.connect(on_player_interacted_door)
	for child: Node in gem_container.get_children():
		if child is Gem:
			child.on_collected.connect(update_gem_count)
			gem_count += 1


func update_gem_count(gem: Gem):
	gem_collected.emit(gem)
	gem_count -= 1
	if gem_count <= 0:
		door.open_door()


func on_player_interacted_door() -> void:
	if door.is_opened:
		next_level.emit()
