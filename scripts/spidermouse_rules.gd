extends Node

var t
var shake
var upgradeAvailable

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
	print("summon a demon")
	upgradeAvailable = false;
	$Pentagram.spawn_summons(Global.summons.MouseSpider, 1);
	$Pentagram.destroy_summons(Global.summons.Spider, 1);
	$Pentagram.destroy_summons(Global.summons.Mouse, 1);
