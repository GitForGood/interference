extends Node2D
class_name ComponentListener

## the minimum percievable volume in decibels for the listener
@export var volume_cutoff_min: float
## the maximum tolerable volume in decibels
@export var volume_cutoff_max: float
## how far below the highest heard sound you can still percieve
@export var perceivable_range: float
## how quickly the listener recovers from a peak
@export_range(0.0,1.0,0.01) var recovery_rate_normal: float
## how quickly the listener recovers from a breached threshold, set to 0 if permanently deaf
@export_range(0.0,1.0,0.01) var recovery_rate_deaf: float

var is_deaf: bool = false
var max_sound_volume: float = volume_cutoff_min
var percieved_sounds_since_last_tick: Dictionary
var noise_floor: float

signal heard(sound: SoundWave, at_volume_db: float)
signal missed(sound: SoundWave)
signal deafened()
signal recovered()

func _physics_process(delta):
	# handle recovery and update noise range
	if is_deaf:
		max_sound_volume = lerp(max_sound_volume, volume_cutoff_min, recovery_rate_deaf * delta)
		if max_sound_volume < volume_cutoff_max:
			is_deaf = false
			recovered.emit()
		return

	max_sound_volume = lerp(max_sound_volume, volume_cutoff_min, recovery_rate_normal * delta)
	noise_floor = max(max_sound_volume-perceivable_range, volume_cutoff_min)
	if max_sound_volume >= volume_cutoff_max:
		is_deaf = true
		deafened.emit()

	for wave in percieved_sounds_since_last_tick.keys():
		heard.emit(wave, percieved_sounds_since_last_tick[wave])
	percieved_sounds_since_last_tick.clear()

func percieve(sound_wave: SoundWave):
	if is_deaf:
		missed.emit(sound_wave)
		return
	var perceived_volume = sound_wave.volume_at(self.global_position)
	if  noise_floor <= perceived_volume and perceived_volume <= max_sound_volume:
		percieved_sounds_since_last_tick[sound_wave] = perceived_volume
	else:
		missed.emit(sound_wave)
