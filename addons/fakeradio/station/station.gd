extends Node

class_name Station

@export var station_name: String = "Station"
@export var station_description: String = ""
@export var music_array: PackedStringArray
@export var shuffle: bool = true
var playlist: AudioStreamPlaylist

func _ready() -> void:
	playlist = AudioStreamPlaylist.new()
	playlist.stream_count = min(music_array.size(), AudioStreamPlaylist.MAX_STREAMS)
	var streams : Array[AudioStream] = []
	for i in playlist.stream_count:
		var track_stream = load(music_array[i])
		streams.append(track_stream)
	if shuffle:
		streams.shuffle()
	for i in streams.size():
		playlist.set_list_stream(i, streams[i])

func get_station_playlist() -> AudioStreamPlaylist:
	return playlist
