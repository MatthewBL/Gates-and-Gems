class_name BossDoorGem
extends Sprite2D


@onready var gem: Sprite2D = %Gem
@onready var idle_particles_2d: GPUParticles2D = %IdleParticles2D


func set_gem_color(color: Color, alpha: float = 1) -> void:
	gem.visible = true
	gem.modulate = color
	gem.modulate.a = alpha
	idle_particles_2d.visible = true
	idle_particles_2d.modulate = color
	idle_particles_2d.modulate.a = alpha
