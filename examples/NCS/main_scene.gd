extends Node2D

@onready var radio = $Radio
@onready var label_name = $CanvasLayer/VBoxContainer/LabelRadioName
@onready var label_desc = $CanvasLayer/VBoxContainer/LabelRadioDesc

func _ready() -> void:
	radio.station_is_changed.connect(update_info)
	radio.play_radio()


func update_info() -> void:
	label_name.text = radio.get_station_name()
	label_desc.text = radio.get_station_description()


func _on_button_next_pressed() -> void:
	radio.switch_to_next()


func _on_button_prev_pressed() -> void:
	radio.switch_to_prev()
