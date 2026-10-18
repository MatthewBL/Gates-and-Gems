class_name FadeInOut

extends CanvasLayer

@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func longFadeIn():
	animation_player.play("long_fade_in")

func fadeIn():
	animation_player.play("fade_in")

func fadeOut():
	animation_player.play("fade_out")

func flash():
	animation_player.play("flash")
