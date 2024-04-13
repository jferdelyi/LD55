extends Node2D


@onready var _score_label := $ScoreScene

func _ready():
	$ScoreScene.start()
	$SpiderCat.setValues(str(Global.spider_for_spider_cat), str(Global.cat_for_spider_cat))
	$MouseCat.setValues(str(Global.mouse_for_cat_mouse), str(Global.cat_for_cat_mouse))
	$SpiderMouse.setValues(str(Global.mouse_for_spider_mouse), str(Global.spider_for_spider_mouse))
	$Demon.setValues(str(Global.spider_cat_for_demons), str(Global.spider_mouse_for_demons), str(Global.cat_mouse_for_demons))
	$SpiderCat.show()
	$MouseCat.show()
	$SpiderMouse.show()
