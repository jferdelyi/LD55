extends Node2D

signal item_selected(item)

@onready var _cat_food_class := preload("res://scenes/creatures/cat_food.tscn")
@onready var _spider_food_class := preload("res://scenes/creatures/spider_food.tscn")

@onready var _top_menu_sprite := $TopMenu
@onready var _item_slot_1 := $TopMenu/ItemSlot1
@onready var _item_slot_2 := $TopMenu/ItemSlot2
@onready var _item_slot_3 := $TopMenu/ItemSlot3


func _ready() -> void:
	pop_menu()


func pop_menu() -> void:
	for i in range(3):
		var _slot : ShelfItemSlot = _top_menu_sprite.get_child(i)
		var _random_value = randi_range(0, 1)
		match _random_value:
			Global.Items.CatFood:
				var _cat_food := _cat_food_class.instantiate()
				_cat_food.connect("clicked", _on_clicked)
				_slot.set_item(_cat_food)
			Global.Items.SpiderFood:
				var _spider_food := _spider_food_class.instantiate()
				_spider_food.connect("clicked", _on_clicked)
				_slot.set_item(_spider_food)
			Global.Items.MouseFood:
				pass
			Global.Items.SacrificialDagger:
				pass
			Global.Items.Candel:
				pass


func _on_clicked(item : Item) -> void:
	#visible = false
	for i in range(3):
		var _slot = _top_menu_sprite.get_child(i)
		_slot.remove_item()
	item.disconnect("clicked", _on_clicked)
	emit_signal("item_selected", item)
