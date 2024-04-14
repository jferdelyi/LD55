extends Node

var upgradeCatMouseAvailable := false
var upgradeSpiderMouseAvailable := false
var upgradeSpiderCatAvailable := false
var upgradeDemonAvailable := false

signal summon_creature;
signal summon_SpiderMouse;
signal summon_SpiderCat;
signal summon_Demon;

func _ready():
	$upgradeCatMouse.transform.connect(spawnCatMouseTransformation)
	$upgradeSpiderMouse.transform.connect(spawnSpiderMouseTransformation)
	$upgradeSpiderCat.transform.connect(spawnSpiderCatTransformation)
	$upgradeDemon.transform.connect(spawnDemonTransformation)
	
func _process(_delta):
	$upgradeCatMouse.disable = !upgradeCatMouseAvailable
	$upgradeSpiderMouse.disable = !upgradeSpiderMouseAvailable
	$upgradeSpiderCat.disable = !upgradeSpiderCatAvailable
	$upgradeDemon.disable = !upgradeDemonAvailable
		
func setValues(spiders, cats):
	$nb_spider.text = str(spiders)
	$nb_cat.text = str(cats)
	
func spawnCatMouseTransformation():
	upgradeCatMouseAvailable = false;
	summon_creature.emit(Global.summons.CatMouse, 1);

func spawnSpiderMouseTransformation():
	upgradeSpiderMouseAvailable = false;
	summon_creature.emit(Global.summons.MouseSpider, 1);
	
func spawnSpiderCatTransformation():
	upgradeSpiderCatAvailable = false;
	summon_creature.emit(Global.summons.SpiderCat, 1);

func spawnDemonTransformation():
	upgradeDemonAvailable = false;
	summon_creature.emit(Global.summons.Demon, 1);

func update_upgradeAvailable(creature, isAvailable):
	if (creature == Global.summons.SpiderCat):
		upgradeSpiderCatAvailable = isAvailable
	elif (creature == Global.summons.MouseSpider):
		upgradeSpiderMouseAvailable = isAvailable
	elif (creature == Global.summons.CatMouse):
		upgradeCatMouseAvailable = isAvailable
	elif (creature == Global.summons.Demon):
		upgradeDemonAvailable = isAvailable
