extends Node2D

@onready var radio = $Radio

func _ready() -> void:
	radio.play()

func _on_button_pressed() -> void:
	radio.switch_to(1)
