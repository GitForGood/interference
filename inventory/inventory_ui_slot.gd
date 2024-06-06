extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/ItemDisplay

func update(slot: InventorySlot):
	if !slot.item:
		item_visual.visible = false
	else:
		if slot.head != Vector2.ZERO:
			$Sprite2D.visible = false
			return
		item_visual.texture = slot.item.texture
		var width = slot.item.horizontal_slots
		var height = slot.item.vertical_slots
		if slot.item.flipped:
			item_visual.rotate(-PI/2)
			width = slot.item.vertical_slots
			height = slot.item.horizontal_slots
		$Sprite2D.scale.x = width
		$Sprite2D.scale.y = height
		item_visual.visible = true
