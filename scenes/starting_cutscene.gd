extends Control

@export var text_label: Label
@export var text_lines: Array[String]
var i = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if i >= text_lines.size():
		text_label.text = ""
	else:
		text_label.text = text_lines[i]
	if Input.is_action_just_pressed("ui_accept"):
		i += 1
