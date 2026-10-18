extends Control

@export var text_label: Label
@export var text_lines: Array[String]
@export var fade_in_out: FadeInOut
@export var level_manager: PackedScene

var i = 0
var input_enabled = false
var time_elapsed = 0
var end = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not end:
		time_elapsed += delta
		if time_elapsed > 1.5:
			input_enabled = true
		if i >= text_lines.size():
			fade_in_out.fadeOut()
			end = true
			await get_tree().create_timer(2).timeout
			self.hide()
			var instance = level_manager.instantiate()
			get_tree().root.add_child(instance)
			fade_in_out.fadeIn()
			queue_free()
		else:
			text_label.text = text_lines[i]
		if input_enabled and Input.is_action_just_pressed("ui_accept"):
			i += 1
