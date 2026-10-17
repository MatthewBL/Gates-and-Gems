class_name Gem
extends Area2D


signal on_collected(gem: Gem)


var id: StringName


func _init() -> void:
	id = name


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerMovement:
		print("Gem obtained")
		on_collected.emit(self)
