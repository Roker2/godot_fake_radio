extends Node2D

@onready var radio = $Radio

func _ready() -> void:
	radio.play()


func _on_button_next_pressed() -> void:
	radio.switch_to_next()


func _on_button_prev_pressed() -> void:
	radio.switch_to_prev()
