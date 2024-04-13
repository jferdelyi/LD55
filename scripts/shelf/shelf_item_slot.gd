extends Node2D
class_name ShelfItemSlot

var _item : Item = null


func is_empty() -> bool:
	return _item == null

func set_item(shelf_item : Item) -> void:
	_item = shelf_item
	add_child(_item)

