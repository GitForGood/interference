extends Line2D
class_name Trail

@export var trail_stats: TrailStats

var start: Vector2
var end: Vector2
var color: Color

func _init(start: Vector2, end: Vector2, trail_stats: TrailStats):
	self.start = start
	self.end = end
	self.trail_stats = trail_stats
	self.color = trail_stats.color
	self.top_level = true

func _ready():
	set_points([start,end])
	width = trail_stats.width
	default_color = trail_stats.color
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), trail_stats.life_time).set_ease(Tween.EASE_OUT)
	tween.finished.connect(func(): queue_free())
	show()

func _physics_process(delta):
	start = lerp(start, end, delta * trail_stats.life_time)
