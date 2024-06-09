extends Control

@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = []

var is_open: bool = false

func _ready():
	inventory.update.connect(update_slots)
	insert_slots()
	update_slots()
	close()

func insert_slots():
	var grid = $NinePatchRect/Control/GridContainer
	var slot_file = preload("res://inventory/inventory_ui_slot.tscn")
	for index in inventory.item_slots.size():
		var slot = slot_file.instantiate()
		slots.append(slot)
		grid.add_child(slot)

func update_slots():
	for i in min(inventory.item_slots.size(), slots.size()):
		slots[i].update(inventory.item_slots[i])

func open():
	is_open = true
	visible = true

func close():
	is_open = false
	visible = false
