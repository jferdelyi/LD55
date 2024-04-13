extends Node

var t
var shake
var upgradeAvailable

func _ready():
	$upgrade.transform.connect(spawnTransformation)
	while (true):
		upgradeAvailable = !upgradeAvailable
		t = 0
		await get_tree().create_timer(1.0).timeout
		
func setValues(spiders, mice):
	$nb_spider.text = spiders
	$nb_mouse.text = mice
	
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
	upgradeAvailable = false;
	#spawn_summons(Global.summons.Demon, 1);
	#destroy_summons(Global.summons.CatMouse, 1);
	#destroy_summons(Global.summons.MouseSpider, 1);
	#destroy_summons(Global.summons.SpiderCat, 1);
