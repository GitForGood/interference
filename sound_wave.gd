extends Resource
class_name SoundWave

const RECORDED_RANGE = GlobalVariables.ONE_METER_DISTANCE

var source: Vector2
var dampened_db: float
var original_volume: float
var sound_path: String

func _init(source: Vector2, volume: float, sound_path: String):
	self.source = source
	self.original_volume = volume
	self.dampened_db = 0.0
	self.sound_path = sound_path

func pass_occluder(occluder: ComponentNoiseOccluder):
	dampened_db += occluder.noise_absorbtion_db

func reflect_perfect(at: Vector2) -> SoundWave:
	return SoundWave.new(at, volume_at(at), sound_path)

func reflect_occluder(occluder: ComponentNoiseOccluder):
	dampened_db += occluder.nosie_reflection_percentage
	return SoundWave.new(occluder.global_position, volume_at(occluder.global_position), sound_path)

func volume_at(destination: Vector2) -> float:
	var length_travelled = (source - destination).length()
	var volume_at_destination = (original_volume - dampened_db) * ((RECORDED_RANGE/length_travelled)**2)
	return volume_at_destination
