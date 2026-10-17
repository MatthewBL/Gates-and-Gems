class_name Gem
extends Area2D


signal on_collected(gem: Gem)


var id: StringName

@onready var destroy_particles_2d: GPUParticles2D = %DestroyParticles2D
@onready var idle_particles_2d: GPUParticles2D = %IdleParticles2D
@onready var sprite_2d: Sprite2D = %Sprite2D


func _ready() -> void:
	id = name


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerMovement:
		on_collected.emit(self)


func destroy() -> void:
	collision_layer = 0
	collision_mask = 0
	var tween: Tween =  create_tween()
	tween.tween_property(sprite_2d, "global_scale", Vector2(0.01, 0.01), 0.2) 
	tween.parallel()
	tween.tween_property(idle_particles_2d, "global_scale", Vector2(0.01, 0.01), 0.2) 
	await tween.finished
	sprite_2d.visible = false
	idle_particles_2d.visible = false
	destroy_particles_2d.emitting = true
	await destroy_particles_2d.finished
	queue_free()
