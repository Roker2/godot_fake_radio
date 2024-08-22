extends AudioStreamPlayer

class_name Radio

@export var current_station = 0
var stations: Array[Station]

func _ready() -> void:
	for child in get_children():
		if child is Station:
			stations.append(child)
	stream = stations[current_station].get_station_playlist()

func switch_to(index: int) -> void:
	var prev_playing = playing
	var position = get_playback_position()
	stream = stations[index].get_station_playlist()
	current_station = index
	if prev_playing:
		play(position)
