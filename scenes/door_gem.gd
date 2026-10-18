class_name DoorGem
extends Sprite2D


@onready var gem: Sprite2D = %Gem
@onready var gpu_particles_2d: GPUParticles2D = %GPUParticles2D


func set_gem_color(color: Color) -> void:
	gem.visible = true
	gem.modulate = color
	gpu_particles_2d.visible = true
	gpu_particles_2d.modulate = color
