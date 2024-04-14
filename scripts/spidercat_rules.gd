extends Node

var upgradeAvailable := false

signal summon_creature;

func _ready():
	$upgrade.transform.connect(spawnTransformation)
	#upgradeAvailable = true
	
func _process(_delta):
	if upgradeAvailable:
		$Alarm.show()
		$Alarm.color = Color(255, 0, 0, sin(PI*Global.time))
		$upgrade.show()
	else:
		$Alarm.hide()
		$upgrade.hide()
		
func setValues(spiders, cats):
	$nb_spider.text = str(spiders)
	$nb_cat.text = str(cats)
	
func spawnTransformation():
	print("summon a spider cat")
	upgradeAvailable = false;
	summon_creature.emit(Global.summons.SpiderCat, 1);

func update_upgradeAvailable(creature, isAvailable):
	if (creature == Global.summons.SpiderCat):
		upgradeAvailable = isAvailable
