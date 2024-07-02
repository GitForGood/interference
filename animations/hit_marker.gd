extends Node2D
class_name HitMarker

const TEXTURE_PATH = "res://assets/sprites/hit_particle.png"
var time_out
var sprite
# Called when the node enters the scene tree for the first time.

func _ready():
	sprite = Sprite2D.new()
	sprite.texture = load(TEXTURE_PATH)
	add_child(sprite)
	var tween = sprite.create_tween()
	tween.tween_property(sprite, "modulate", Color(1,1,1,0), time_out).set_ease(Tween.EASE_IN)
	tween.finished.connect(func(): queue_free())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _init(position: Vector2, duration: float):
	time_out = duration
	self.position = position
