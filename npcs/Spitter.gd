extends Node2D

@onready var sprite: HideableSprite = $HideableSprite

var hearing_range: float
var hearing_range_modifiers: float


func damage(amount: int):
	print("I: " + str(self) + " took: " + str(amount) + " damage!")
