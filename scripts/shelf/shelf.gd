extends Node2D


signal item_used(item)

@onready var _shelf := $Shelf

var _positions := []
var _item_count := 0


func _ready() -> void:
	for i in range(9):
		var _instance := _shelf.get_child(i)
		_positions.append(_instance)

func add_item(item : Item) -> void:
	for i : ShelfItemSlot in _positions:
		if i.is_empty():
			i.set_item(item)
			item.connect("clicked", on_item_clicked)
			_item_count = _item_count + 1
			return

func on_item_clicked(item : Item) -> void:
	print("clicked")
	item.queue_free()
	_item_count = _item_count - 1
	emit_signal("item_used", item)
