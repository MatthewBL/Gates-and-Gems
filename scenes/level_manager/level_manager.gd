class_name LevelManager
extends Node2D


@export var levels: Array[PackedScene]
@export var player: PlayerMovement
@export var fade_in_out: FadeInOut
@export var end_screen: CanvasLayer


var current_level_index: int = 0
var current_level: Level


@onready var level_container: Node2D = %LevelContainer


func _ready() -> void:
	load_level(0)


func load_level(level_index: int) -> void:
	if level_index == levels.size():
		get_tree().quit()
		return
	
	current_level_index = level_index
	current_level = levels[current_level_index].instantiate() as Level
	level_container.add_child(current_level)
	
	if not current_level.is_node_ready():
		await current_level.ready
	await get_tree().physics_frame
	
	player.global_position = current_level.player_spawnpoint.global_position
	current_level.gem_collected.connect(free_gem)
	current_level.next_level.connect(on_next_level)
	current_level.open_door_signal.connect(shake_camera)
	current_level.boss_door_opened.connect(flash)
	
	var offsets: Array[Vector2] = [
		Vector2(current_level.width, 0.0), #RIGHT
		Vector2(-current_level.width, 0.0), #LEFT
		Vector2(0.0, current_level.height), #DOWN
		Vector2(0.0, -current_level.height), #UP
		Vector2(current_level.width, -current_level.height), #UP-RIGHT
		Vector2(-current_level.width, -current_level.height), #UP-LEFT
		Vector2(current_level.width, current_level.height), #DOWN-RIGHT
		Vector2(-current_level.width, current_level.height), #DOWN-LEFT
	]
	for offset: Vector2 in offsets:
		var level_instance: Node2D = current_level.duplicate()
		level_container.add_child(level_instance)
		level_instance.position += offset


func _physics_process(_delta: float) -> void:
	if player.global_position.x > current_level.width:
		player.global_position.x -= current_level.width
	elif player.global_position.x < 0:
		player.global_position.x += current_level.width
	
	if player.global_position.y > current_level.height:
		player.global_position.y -= current_level.height
	elif player.global_position.y < 0:
		player.global_position.y += current_level.height


func free_gem(target_gem: Gem) -> void:
	var gems = get_tree().get_nodes_in_group("Gem")
	var id = target_gem.id
	for gem in gems:
		if gem.id == id and gem != target_gem:
			gem.destroy()
	var color: Color = target_gem.modulate
	target_gem.destroy()
	await target_gem.collected_completed
	for level: Node in level_container.get_children():
		level.add_door_gem(color)



func on_next_level() -> void:
	player.allow_movement = false
	fade_in_out.fadeOut()
	await get_tree().create_timer(1).timeout
	if current_level_index + 1 < levels.size():
		for level: Node in level_container.get_children():
			level.queue_free()
		load_level.call_deferred(current_level_index + 1)
		await get_tree().create_timer(0.1).timeout
		player.allow_movement = true
	end_screen.show()
	fade_in_out.fadeIn()

func shake_camera() -> void:
	player.shakeCamera()

func flash() -> void:
	fade_in_out.flash()
