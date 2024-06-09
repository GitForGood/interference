extends Panel

@onready var item_display: TextureRect = $ItemDisplay
const SLOT_SIZE = 64
var displaying: InventorySlot

func update(slot: InventorySlot):
	displaying = slot
	if !slot.item:
		item_display.visible = false
	else:
		if slot.head != Vector2.ZERO:
			$Background.visible = false
			return
		item_display.rotation = 0
		item_display.texture = slot.item.texture
		var width = slot.item.horizontal_slots
		var height = slot.item.vertical_slots
		if slot.item.flipped:
			item_display.rotation = -PI/2
			width = slot.item.vertical_slots
			height = slot.item.horizontal_slots
		$Background.size.x = width * SLOT_SIZE
		$Background.size.y = height * SLOT_SIZE
		item_display.scale = Vector2(width,height)
		item_display.visible = true
