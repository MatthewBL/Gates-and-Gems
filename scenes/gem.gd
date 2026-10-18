class_name Gem
extends Area2D


signal on_collected(gem: Gem)
signal collected_completed

var id: StringName

@onready var destroy_particles_2d: GPUParticles2D = %DestroyParticles2D
@onready var idle_particles_2d: GPUParticles2D = %IdleParticles2D
@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var point_light_2d: PointLight2D = %PointLight2D


func _ready() -> void:
	id = name
	point_light_2d.color = modulate


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerMovement:
		on_collected.emit(self)


func destroy() -> void:
	collision_layer = 0
	collision_mask = 0
	var tween: Tween =  create_tween()
	tween.tween_property(sprite_2d, "global_scale", Vector2(0.01, 0.01), 0.1) 
	tween.parallel()
	tween.tween_property(idle_particles_2d, "global_scale", Vector2(0.01, 0.01), 0.1) 
	await tween.finished
	collected_completed.emit()
	destroy_particles_2d.modulate = modulate
	destroy_particles_2d.emitting = true
	queue_free()
