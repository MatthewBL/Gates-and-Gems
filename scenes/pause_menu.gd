extends CanvasLayer

@export var main_options: VBoxContainer
@export var settings_menu: VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			unpause()
		else:
			pause()
	
func pause():
	get_tree().paused = true;
	self.show()

func unpause():
	_on_apply_pressed()
	get_tree().paused = false;
	self.hide()

func _on_resume_pressed() -> void:
	unpause()

func _on_settings_pressed() -> void:
	main_options.hide()
	settings_menu.show()

func _on_exit_pressed() -> void:
	get_tree().quit()
	pass

func _on_apply_pressed() -> void:
	main_options.show()
	settings_menu.hide()
