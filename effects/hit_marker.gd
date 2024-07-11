extends Node2D
class_name HitMarker


var texture: Texture
var sprite: Sprite2D
var particles: GPUParticles2D
# Called when the node enters the scene tree for the first time.

func _init(texture: Texture, particles: GPUParticles2D, position: Vector2, rotation: float):
	self.texture = texture
	self.sprite = Sprite2D.new()
	self.particles = particles
	self.global_position = position
	self.rotate(rotation)

func _ready():
	sprite.texture = texture
	add_child(sprite)
	particles.emitting = true
	add_child(particles)
	particles.finished.connect(func(): queue_free())
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
