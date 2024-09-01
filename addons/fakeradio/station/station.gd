extends Node
class_name Station

## Station class.
##
## Allow to create a music playlist as a radio station.

## A station name
@export var station_name: String = "Station"
## A station descrition
@export var station_description: String = ""
## A music list
@export var music_array: PackedStringArray
## Shuffle a music list or not
@export var shuffle: bool = true
## A generated audio stream playlist
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

## Returns generated audio stream playlist
func get_station_playlist() -> AudioStreamPlaylist:
	return playlist
