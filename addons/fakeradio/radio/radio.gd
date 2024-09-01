extends AudioStreamPlayer
class_name Radio

## Radio class.
##
## Allows to play, stop listening audio streams from stations and to switch
## between stations

## Emitted when a station is changed
signal station_is_changed
## Emitted when a radio is stopped work
signal stopped
## Emitted when a radio is started to work
signal started

## A current stations
@export var current_station = 0
## Allow to choose process callback backend
@export_enum("Idle", "Physics") var process_callback: String = "Idle"
var _stations: Array[Station]
var _stopwatch: float = 0
var _process_stopwatch_in_physics: bool = false

func _ready() -> void:
	for child in get_children():
		if child is Station:
			_stations.append(child)
	stream = _get_current_station().get_station_playlist()
	
	if process_callback == "Physics":
		_process_stopwatch_in_physics = true

## Enable a radio
func play_radio() -> void:
	play(_stopwatch)
	started.emit()

## Stop a radio
func stop_radio() -> void:
	stop()
	stopped.emit()

## Switch to another station by index
func switch_to(index: int) -> void:
	if index >= _stations.size():
		printerr("index is not valid")
		return
	var prev_playing = playing
	stream = _stations[index].get_station_playlist()
	current_station = index
	if prev_playing:
		play(_stopwatch)
	station_is_changed.emit()

## Switch to next station
func switch_to_next() -> void:
	if current_station == _stations.size() - 1:
		switch_to(0)
	else:
		switch_to(current_station + 1)

## Switch to previous station
func switch_to_prev() -> void:
	if current_station == 0:
		switch_to(_stations.size() - 1)
	else:
		switch_to(current_station - 1)

## Get stattion name
func get_station_name() -> String:
	return _get_current_station().station_name

## Get station description
func get_station_description() -> String:
	return _get_current_station().station_description

func _get_current_station() -> Station:
	return _stations[current_station]

func _process(delta: float) -> void:
	if not _process_stopwatch_in_physics:
		_stopwatch += delta

func _physics_process(delta: float) -> void:
	if _process_stopwatch_in_physics:
		_stopwatch += delta
