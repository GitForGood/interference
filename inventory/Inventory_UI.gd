extends Control

@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/Control/GridContainer.get_children()

var is_open: bool = false

func _ready():
	update_slots()
	close()

func update_slots():
	for i in min(inventory.item_slots.size(), slots.size()):
		slots[i].update(inventory.item_slots[i])

func open():
	is_open = true
	visible = true

func close():
	is_open = false
	visible = false
