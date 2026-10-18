extends Control


@onready var keyboard_texture_rect: TextureRect = %KeyboardTextureRect
@onready var gamepad_texture_rect: TextureRect = %GamepadTextureRect
@onready var keyboard_texture_rect_2: TextureRect = %KeyboardTextureRect2
@onready var gamepad_texture_rect_2: TextureRect = %GamepadTextureRect2
@onready var gamepad_texture_rect_3: TextureRect = %GamepadTextureRect3
@onready var keyboard_texture_rect_3: TextureRect = %KeyboardTextureRect3


func _input(event: InputEvent) -> void:
	var show_gamepad: bool = event is InputEventJoypadButton or event is InputEventJoypadMotion
	
	gamepad_texture_rect.visible = show_gamepad
	gamepad_texture_rect_2.visible = show_gamepad
	gamepad_texture_rect_3.visible = show_gamepad
	
	keyboard_texture_rect.visible = not show_gamepad
	keyboard_texture_rect_2.visible = not show_gamepad
	keyboard_texture_rect_3.visible = not show_gamepad
