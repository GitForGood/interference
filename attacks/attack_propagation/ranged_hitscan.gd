extends AttackPropagation
class_name HitscanStats

@export var hitscan_range: float = INF
@export var hitscan_bounces: int = 0

@export_category("tracers")
@export var hitscan_draw: bool = false
@export var hitscan_draw_width: float = 1.0
@export var hitscan_draw_color: Color = Color.SLATE_GRAY
