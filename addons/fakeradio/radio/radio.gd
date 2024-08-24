extends AudioStreamPlayer

class_name Radio

signal station_is_changed

@export var current_station = 0
@export_enum("Idle", "Physics") var process_callback: String = "Idle"
var stations: Array[Station]
var stopwatch: float = 0
var process_stopwatch_in_physics: bool = false

func _ready() -> void:
	for child in get_children():
		if child is Station:
			stations.append(child)
	stream = _get_current_station().get_station_playlist()

func play_radio() -> void:
	station_is_changed.emit()
	play(stopwatch)

func stop_radio() -> void:
	station_is_changed.emit()
	stop()

func switch_to(index: int) -> void:
	if index >= stations.size():
		printerr("index is not valid")
		return
	var prev_playing = playing
	stream = stations[index].get_station_playlist()
	current_station = index
	if prev_playing:
		play(stopwatch)
	station_is_changed.emit()

func switch_to_next() -> void:
	if current_station == stations.size() - 1:
		switch_to(0)
	else:
		switch_to(current_station + 1)

func switch_to_prev() -> void:
	if current_station == 0:
		switch_to(stations.size() - 1)
	else:
		switch_to(current_station - 1)

func get_station_name() -> String:
	return _get_current_station().station_name

func get_station_description() -> String:
	return _get_current_station().station_description

func _get_current_station() -> Station:
	return stations[current_station]

func _process(delta: float) -> void:
	if not process_stopwatch_in_physics:
		stopwatch += delta

func _physics_process(delta: float) -> void:
	if process_stopwatch_in_physics:
		stopwatch += delta
