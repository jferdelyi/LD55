extends Node2D

#@onready var _shelf_item_class := preload("res://scenes/creatures/cat_food.tscn")
@onready var _score_label := $ScoreScene
@onready var _shelf := $Shelf
@onready var _pentagram := $Pentagram
@onready var _spider_cat := $SpiderCat
@onready var _mouse_cat := $MouseCat
@onready var _spider_mouse := $SpiderMouse
@onready var _demon := $Demon
#@onready var _audio_player := $AudioStreamPlayer


func _ready():
	var summ = Global.summons
	_score_label.start()
	_spider_cat.setValues(
		Global.get_requirements_for_with(summ.SpiderCat, summ.Spider),
		Global.get_requirements_for_with(summ.SpiderCat, summ.Cat))
	_mouse_cat.setValues(
		Global.get_requirements_for_with(summ.CatMouse, summ.Mouse),
		Global.get_requirements_for_with(summ.CatMouse, summ.Cat))
	_spider_mouse.setValues(
		Global.get_requirements_for_with(summ.MouseSpider, summ.Mouse),
		Global.get_requirements_for_with(summ.MouseSpider, summ.Spider))
	_demon.setValues(
		Global.get_requirements_for_with(summ.Demon, summ.SpiderCat),
		Global.get_requirements_for_with(summ.Demon, summ.MouseSpider),
	 	Global.get_requirements_for_with(summ.Demon, summ.CatMouse))
	_spider_cat.show()
	_mouse_cat.show()
	_spider_mouse.show()

func _on_shelf_item_used(item: Variant) -> void:
	if item is CatFood:
		_pentagram.spawn_summons(Global.summons.Cat, 1)

func _on_pop_menu_item_selected(item: Variant) -> void:
	_shelf.add_item(item)


func _on_candle_light_off() -> void:
	# GAME OVER
	get_tree().change_scene_to_file("res://scenes/game_main.tscn")
