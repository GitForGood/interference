extends Area2D
class_name ComponentNoiseOccluder

@export_range(0.0,100.0) var noise_absorbtion_db: float
@export_range(0.0,100.0) var volume_cutoff_db: float
@export_range(-100.0,100.0) var nosie_reflection_amplification: float

func pong():
	pass

func penetrate(wave: SoundWave):
	pass
