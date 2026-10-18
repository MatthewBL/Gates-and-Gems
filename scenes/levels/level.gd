class_name Level
extends Node2D


enum DOOR_GEM_TYPE {
	NORMAL,
	BOSS
}


signal gem_collected(gem: Gem)
signal next_level
signal open_door_signal
signal boss_door_opened


@export var width: float:
	get:
		return width * 16 + 16
@export var height: float:
	get:
		return height * 16 + 16
@export var door_gem_type: DOOR_GEM_TYPE = DOOR_GEM_TYPE.NORMAL


var gem_count: int
var max_gem_count: int
var door_gem_index: int = 0

@onready var gem_container: Node2D = %GemContainer
@onready var door: Door = %Door
@onready var player_spawnpoint: Marker2D = %PlayerSpawnpoint
@onready var collect_gem_sfx: AudioStreamPlayer = %CollectGemSFX
@onready var open_door_sfx: AudioStreamPlayer = %OpenDoorSFX
@onready var door_gems_container: Node2D = %DoorGemsContainer


var doors


func _ready() -> void:
	door.player_interacted.connect(on_player_interacted_door)
	for child: Node in gem_container.get_children():
		if child is Gem:
			child.on_collected.connect(update_gem_count)
			gem_count += 1
	max_gem_count = gem_count


func update_gem_count(gem: Gem):
	gem_collected.emit(gem)
	gem_count -= 1
	collect_gem_sfx.play()
	if gem_count <= 0:
		doors = get_tree().get_nodes_in_group("Door")
		for door_instance in doors:
			door_instance.open_door()
			open_door_sfx.play()
			open_door_signal.emit()
			if door_gem_type == DOOR_GEM_TYPE.BOSS:
				boss_door_opened.emit()


func on_player_interacted_door() -> void:
	if door.is_opened:
		door.play_footsteps()
		next_level.emit()


func add_door_gem(color: Color) -> void:
	if door_gem_type == DOOR_GEM_TYPE.NORMAL:
		(door_gems_container.get_child(door_gem_index) as DoorGem).set_gem_color(color)
		door_gem_index += 1
	else:
		var alpha = 0
		if gem_count == 0:
			alpha = 1
		else:
			alpha = 0.75 - (gem_count as float / max_gem_count as float) * 0.75
		(door_gems_container.get_child(0) as BossDoorGem).set_gem_color(color, alpha)
