extends Control

@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/Control/GridContainer.get_children()

var is_open: bool = false

func _ready():
	update_slots()
	close()

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()

func update_slots():
	for i in min(inventory.items.size(), slots.size()):
		slots[i].update(inventory.items[i])

func open():
	is_open = true
	visible = true

func close():
	is_open = false
	visible = false
