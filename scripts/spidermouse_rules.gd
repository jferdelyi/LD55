extends Node

var t
var shake
var upgradeAvailable

signal summon_spidermouse;

func _ready():
	t = 0
	$upgrade.transform.connect(spawnTransformation)
	upgradeAvailable = true
		
func setValues(spiders, mice):
	$nb_spider.text = str(spiders)
	$nb_mouse.text = str(mice)
	
func _process(_delta):
	if upgradeAvailable:
		t = t + 1
		$Alarm.show()
		$Alarm.color = Color(255, 0, 0, sin(0.1*t))
		$upgrade.show()
	else:
		$Alarm.hide()
		$upgrade.show()

func spawnTransformation():
	print("summon a spidermouse")
	upgradeAvailable = false;
	summon_spidermouse.emit();
