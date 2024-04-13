extends Node

var t
var shake
var upgradeAvailable

signal summon_spidercat;

func _ready():
	t = 0
	$upgrade.transform.connect(spawnTransformation)
	upgradeAvailable = true
	
func _process(_delta):
	if upgradeAvailable:
		t = t + 1
		$Alarm.show()
		$Alarm.color = Color(255, 0, 0, sin(0.1*t))
		$upgrade.show()
	else:
		$Alarm.hide()
		$upgrade.show()
		
func setValues(spiders, cats):
	$nb_spider.text = str(spiders)
	$nb_cat.text = str(cats)
	
func spawnTransformation():
	print("summon a spider cat")
	upgradeAvailable = false;
	summon_spidercat.emit();
