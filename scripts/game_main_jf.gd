extends Node2D

@onready var _shelf_item_class := preload("res://scenes/creatures/cat_food.tscn")
@onready var _score_label := $Score
@onready var _shelf := $Shelf
@onready var _pentagram := $Pentagram

func _ready():
	_shelf.add_item(_shelf_item_class.instantiate())
	_shelf.add_item(_shelf_item_class.instantiate())
	_shelf.add_item(_shelf_item_class.instantiate())
	_shelf.add_item(_shelf_item_class.instantiate())
	_shelf.add_item(_shelf_item_class.instantiate())


func _on_shelf_item_used(item: Item) -> void:
	if item is CatFood:
		_pentagram.spawn_summons(Global.summons.Cat, 1)

