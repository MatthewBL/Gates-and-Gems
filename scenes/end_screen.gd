extends CanvasLayer


@onready var button: Button = %Button


func _ready() -> void:
	button.pressed.connect(close_game)


func close_game() -> void:
	get_tree().quit()
