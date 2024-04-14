extends Node

var upgradeAvailable := false

signal summon_creature;

func _ready():
	$upgrade.transform.connect(spawnTransformation)
	
func _process(_delta):
	if upgradeAvailable:
		$Alarm.show()
		$Alarm.color = Color(255, 0, 0, sin(PI*Global.time))
		$upgrade.show()
	else:
		$Alarm.hide()
		$upgrade.hide()
		
func setValues(spidercat, spidermouse, catmouse):
	$nb_spidercat.text = str(spidercat)
	$nb_spidermouse.text = str(spidermouse)
	$nb_catmouse.text = str(catmouse)

func spawnTransformation():
	print("summon a demon")
	upgradeAvailable = false;
	summon_creature.emit(Global.summons.Demon, 1);

func update_upgradeAvailable(creature, isAvailable):
	if (creature == Global.summons.Demon):
		upgradeAvailable = isAvailable
