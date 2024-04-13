extends Node2D


@onready var _score_label := $ScoreScene

func _ready():
	var summ = Global.summons
	$ScoreScene.start()
	$SpiderCat.setValues(
		Global.get_requirements_for_with(summ.SpiderCat, summ.Spider),
		Global.get_requirements_for_with(summ.SpiderCat, summ.Cat))
	$MouseCat.setValues(
		Global.get_requirements_for_with(summ.CatMouse, summ.Mouse),
		Global.get_requirements_for_with(summ.CatMouse, summ.Cat))
	$SpiderMouse.setValues(
		Global.get_requirements_for_with(summ.MouseSpider, summ.Mouse),
		Global.get_requirements_for_with(summ.MouseSpider, summ.Spider))
	$Demon.setValues(
		Global.get_requirements_for_with(summ.Demon, summ.SpiderCat),
		Global.get_requirements_for_with(summ.Demon, summ.MouseSpider),
	 	Global.get_requirements_for_with(summ.Demon, summ.MouseCat))
	$SpiderCat.show()
	$MouseCat.show()
	$SpiderMouse.show()
