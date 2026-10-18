class_name BossDoorGem
extends Sprite2D


@onready var gem: Sprite2D = %Gem
@onready var idle_particles_2d: GPUParticles2D = %IdleParticles2D
@onready var point_light_2d: PointLight2D = %PointLight2D


func set_gem_color(color: Color, alpha: float = 1) -> void:
	gem.visible = true
	gem.modulate = color
	gem.modulate.a = alpha
	if alpha == 1.0:
		idle_particles_2d.visible = true
		idle_particles_2d.modulate = color
		idle_particles_2d.modulate.a = alpha
		point_light_2d.visible = true
		point_light_2d.color = color
