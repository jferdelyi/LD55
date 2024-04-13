extends Node

var t
var shake
var upgradeAvailable

signal summon_demon;

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
		
func setValues(spidercat, spidermouse, catmouse):
	$nb_spidercat.text = str(spidercat)
	$nb_spidermouse.text = str(spidermouse)
	$nb_catmouse.text = str(catmouse)

func spawnTransformation():
	print("summon a demon")
	upgradeAvailable = false;
	summon_demon.emit();
