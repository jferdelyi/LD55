extends Node

signal timeout

const TIME_PERIOD = 1 # 1s

var time = 0
var CandleLife := 10

enum summons {Cat, Spider, Mouse, SpiderCat, CatMouse, MouseSpider, Demon}
enum Items {CatFood, SpiderFood, MouseFood, Candel, SacrificialDagger}


var summons_requirements = {}

func get_requirements_for_with(summoned : Global.summons, summoner : Global.summons) -> int:
	if summoned in summons_requirements.keys():
		var summoners = summons_requirements[summoned]
		if summoner in summoners.keys():
			return summoners[summoner]
	return 0
		

func _ready():
	
	var required_for_spider_cat = {}
	required_for_spider_cat[Global.summons.Spider] = 1
	required_for_spider_cat[Global.summons.Cat] = 1

	var required_for_mouse_spider = {}
	required_for_mouse_spider[Global.summons.Spider] = 1
	required_for_mouse_spider[Global.summons.Mouse] = 1
	
	var required_for_cat_mouse = {}
	required_for_cat_mouse[Global.summons.Mouse] = 1
	required_for_cat_mouse[Global.summons.Cat] = 1
	
	var required_for_demon = {}
	required_for_demon[Global.summons.CatMouse] = 1
	required_for_demon[Global.summons.SpiderCat] = 1
	required_for_demon[Global.summons.MouseSpider] = 1
	
	summons_requirements[Global.summons.SpiderCat] = required_for_spider_cat
	summons_requirements[Global.summons.CatMouse] = required_for_cat_mouse
	summons_requirements[Global.summons.MouseSpider] = required_for_mouse_spider
	summons_requirements[Global.summons.Demon] = required_for_demon

func _process(delta):
	time += delta
	if time > TIME_PERIOD:
		emit_signal("timeout")
		# Reset timer
		time = 0
