class_name BossDoorGem
extends Sprite2D


@onready var gem: Sprite2D = %Gem


func set_gem_color(color: Color) -> void:
	gem.visible = true
	gem.modulate = color
