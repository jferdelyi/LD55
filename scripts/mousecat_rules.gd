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

func setValues(mice, cats):
	$nb_mouse.text = str(mice)
	$nb_cat.text = str(cats)

func spawnTransformation():
	print("summon a mousecat")
	upgradeAvailable = false;
	summon_creature.emit(Global.summons.CatMouse, 1);

func update_upgradeAvailable(creature, isAvailable):
	if (creature == Global.summons.CatMouse):
		upgradeAvailable = isAvailable
