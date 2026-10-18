class_name BossDoorGem
extends Sprite2D


@onready var gem: Sprite2D = %Gem


func set_gem_color(color: Color, alpha: float = 1) -> void:
	gem.visible = true
	gem.modulate = color
	gem.modulate.a = alpha
