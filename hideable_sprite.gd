extends Node2D
class_name HideableSprite

@export var sprite: AnimatedSprite2D
@export var once_spotted_stay_visible: bool

var spotted: bool = true

func _ready():
	spotted = false
	sprite.visible = false

func spot():
	if spotted:
		return
	spotted = true
	sprite.visible = true
	visibility_changed.emit()

func unspot():
	if once_spotted_stay_visible or not spotted:
		return
	spotted = false
	sprite.visible = false
	visibility_changed.emit()
