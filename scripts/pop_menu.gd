extends Node2D

signal item_selected(item)

@onready var _cat_food_class := preload("res://scenes/creatures/cat_food.tscn")

@onready var item_slot_1 := $ItemSlot1
@onready var item_slot_2 := $ItemSlot2
@onready var item_slot_3 := $ItemSlot3


func _ready() -> void:
	pop_menu()


func pop_menu() -> void:
	for i in range(3):
		var _slot = get_child(i)
		var _random_value = Global.Items.CatFood #randi_range(0, Global.Items.keys().size())
		match _random_value:
			Global.Items.CatFood:
				var _cat_food := _cat_food_class.instantiate()
				_cat_food.connect("clicked", _on_clicked)
				_slot.set_item(_cat_food)
			Global.Items.SpiderFood:
				pass
			Global.Items.MouseFood:
				pass
			Global.Items.SacrificialDagger:
				pass
			Global.Items.Candel:
				pass


func _on_clicked(item : Item) -> void:
	visible = false
	for i in range(3):
		var _slot = get_child(i)
		_slot.remove_item()
	item.disconnect("clicked", _on_clicked)
	emit_signal("item_selected", item)
