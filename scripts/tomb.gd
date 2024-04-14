extends Node

signal summon_creature;

func _ready():
	$upgradeCatMouse.transform.connect(spawnTransformation.bind(Global.summons.CatMouse))
	$upgradeSpiderMouse.transform.connect(spawnTransformation.bind(Global.summons.MouseSpider))
	$upgradeSpiderCat.transform.connect(spawnTransformation.bind(Global.summons.SpiderCat))
	$upgradeDemon.transform.connect(spawnTransformation.bind(Global.summons.Demon))
	
func setValues(SpiderForSpiderCat, CatForSpiderCat, MouseForCatMouse, CatForCatMouse, MouseForMouseSpider, SpiderForMouseSpider, SpiderCatForDemon, MouseSpiderForDemon, CatMouseForDemon):
	$nb_spider_for_spidercat.text = str(SpiderForSpiderCat)
	$nb_cat_for_spidercat.text = str(CatForSpiderCat)
	$nb_mouse_for_catmouse.text = str(MouseForCatMouse)
	$nb_cat_for_catmouse.text = str(CatForCatMouse)
	$nb_mouse_for_spidermouse.text = str(MouseForMouseSpider)
	$nb_spider_for_spidermouse.text = str(SpiderForMouseSpider)
	
func spawnTransformation(type):
	match type:
		Global.summons.CatMouse:
			summon_creature.emit(Global.summons.CatMouse, 1);
		Global.summons.MouseSpider:
			summon_creature.emit(Global.summons.MouseSpider, 1);
		Global.summons.SpiderCat:
			summon_creature.emit(Global.summons.SpiderCat, 1);
		Global.summons.Demon:
			summon_creature.emit(Global.summons.Demon, 1);

func update_upgradeAvailable(creature, isAvailable):
	if (creature == Global.summons.SpiderCat):
		$upgradeSpiderCat.set_visible(isAvailable)
	elif (creature == Global.summons.MouseSpider):
		$upgradeSpiderMouse.set_visible(isAvailable)
	elif (creature == Global.summons.CatMouse):
		$upgradeCatMouse.set_visible(isAvailable)
	elif (creature == Global.summons.Demon):
		$upgradeDemon.set_visible(isAvailable)
