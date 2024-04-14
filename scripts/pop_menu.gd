extends Node2D

signal item_selected(item)

@onready var _cat_food_class := preload("res://scenes/creatures/cat_food.tscn")
@onready var _spider_food_class := preload("res://scenes/creatures/spider_food.tscn")
@onready var _mouse_food_class := preload("res://scenes/creatures/mouse_food.tscn")
@onready var _candle_class := preload("res://scenes/creatures/candle.tscn")

@onready var _top_menu_sprite := $TopMenu

var show := false
var t = 0
var POP_TIME_CONSTANT := 6
var DISAPPEAR_TIME_CONSTANT := 3
	
func _process(delta):
	t = t + delta
	if (show and t > DISAPPEAR_TIME_CONSTANT):
		t = 0;
		show = false;
		removeChoices();
	if (!show and t > POP_TIME_CONSTANT):
		t = 0
		show = true;
		pop_menu();

func pop_menu() -> void:
	for i in range(3):
		var _slot : ShelfItemSlot = _top_menu_sprite.get_child(i)
		var _random_value = randi_range(0, 3)
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
				var _mouse_food := _mouse_food_class.instantiate()
				_mouse_food.connect("clicked", _on_clicked)
				_slot.set_item(_mouse_food)
			Global.Items.Candel:
				var _candle := _candle_class.instantiate()
				_candle.connect("clicked", _on_clicked)
				_slot.set_item(_candle)
				pass
			Global.Items.SacrificialDagger:
				pass


func _on_clicked(item : Item) -> void:
	removeChoices()
	item.disconnect("clicked", _on_clicked)
	emit_signal("item_selected", item)
	pop_menu()
		
func removeChoices():
	for i in range(3):
		var _slot = _top_menu_sprite.get_child(i)
		_slot.remove_item()

