extends Area2D

@export var listen_to_pong: bool = false
@export var true_noise: bool = false
@export var range: float

signal made_some_noise(sound_wave: SoundWave)

@onready var area: CollisionShape2D = $CollisionShape2D

func ping(volume_in_db: float):
	pass

func interpret(sound_wave: SoundWave):
	pass
