extends Control

@export_range(0,9999) var value: int 

@onready var thousandth = $Kilo
@onready var hundredth = $Hekta
@onready var tenth = $Deca
@onready var digit = $Digit

# Called when the node enters the scene tree for the first time.
func _ready():
	thousandth.set_frame(10)
	hundredth.set_frame(10)
	tenth.set_frame(10)
	digit.set_frame(10)
	pass # Replace with function body.

func update_value(to: int):
	assert (to in range(10000))
	_set_display_to_digit(thousandth, to / 1000)
	var hundreds: int = to % 1000
	_set_display_to_digit(hundredth, hundreds / 100)
	var tenths: int = hundreds % 100
	_set_display_to_digit(tenth, tenths / 10)
	var digits = tenths % 10
	_set_display_to_digit(digit, digits)

func _set_display_to_digit(display: AnimatedSprite2D, digit: int):
	if display.get_frame() == digit:
		return
	var fade_out = display.create_tween()
	fade_out.tween_property(display, "modulate", Color(1,1,1,0), 0)
	display.set_frame(digit)
	var fade_in = display.create_tween()
	fade_in.tween_property(display, "modulate", Color(1,1,1,1), 0.5).set_trans(Tween.TRANS_EXPO)
