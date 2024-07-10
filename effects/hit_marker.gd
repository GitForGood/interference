extends Node2D
class_name HitMarker

const TEXTURE_PATH = "res://assets/sprites/shotgun_bullet.png"
var time_out: float
var sprite: Sprite2D
var global_origin: Vector2
var line: Line2D
var line_color: Color = Color.WEB_GRAY
# Called when the node enters the scene tree for the first time.

func _ready():
	line = Line2D.new()
	line.add_point(Vector2.ZERO)
	line.add_point(to_local(global_origin))
	line.width = 0.5
	line.default_color = line_color
	add_child(line)
	var line_tween = create_tween()
	line_tween.tween_property(line, "modulate", Color(1,1,1,0), time_out/2.0).set_ease(Tween.EASE_IN)
	
	sprite = Sprite2D.new()
	sprite.texture = load(TEXTURE_PATH)
	sprite.rotation = (line.points[0] - line.points[1]).angle()
	add_child(sprite)
	var tween = sprite.create_tween()
	tween.tween_property(sprite, "modulate", Color(1,1,1,0), time_out).set_ease(Tween.EASE_IN)
	tween.finished.connect(func(): queue_free())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _init(global_origin: Vector2, position: Vector2, duration: float):
	time_out = duration
	self.position = position
	self.global_origin = global_origin
